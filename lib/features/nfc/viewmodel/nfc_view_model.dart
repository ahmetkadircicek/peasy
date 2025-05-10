import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:peasy/core/init/network/nfc_product_service.dart';
import 'package:peasy/features/category/model/product_model.dart';

class NFCViewModel extends ChangeNotifier {
  final NFCProductService _nfcProductService = NFCProductService();

  bool _isScanning = false;
  bool get isScanning => _isScanning;

  bool _isError = false;
  bool get isError => _isError;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ProductModel? _product;
  ProductModel? get product => _product;

  /// NFC tarama işlemini başlatır
  Future<void> startNFCScan() async {
    try {
      _isScanning = true;
      _isError = false;
      _errorMessage = null;
      _product = null;
      notifyListeners();

      // iOS ve Android platformlarında NFC hata yönetimi
      try {
        // NFC cihazının kullanılabilirliğini kontrol et
        final availability = await FlutterNfcKit.nfcAvailability;
        if (availability != NFCAvailability.available) {
          _setError('NFC is not available on this device.');
          return;
        }
      } catch (e) {
        debugPrint('[NFCViewModel] NFC availability check error: $e');
        // iOS'ta "service invalidated" hatası için özel işlem
        if (e.toString().contains(
            'service named com.apple.nfcd.service.corenfc was invalidated')) {
          _handleIOSNFCServiceError();
          return;
        }
      }

      // NFC taramayı başlat
      debugPrint('[NFCViewModel] Starting NFC scan...');

      // NFC etiketi okuma işlemi
      final tag = await FlutterNfcKit.poll(
        timeout: Duration(seconds: 20),
        iosMultipleTagMessage:
            "Multiple tags detected, please present only one tag",
        iosAlertMessage: "Hold your iPhone near the NFC tag",
      );

      debugPrint('[NFCViewModel] NFC tag found: ${tag.id}');

      // Okunan etiket verisini işleme
      final productData = await _processTagData(tag);
      if (productData != null) {
        _product = productData;
        _isScanning = false;
        notifyListeners();
      } else {
        _setError('Invalid product data in the tag.');
      }
    } on PlatformException catch (e) {
      if (e.code == 'timeout') {
        _setError('Scanning timed out. Please try again.');
      } else if (e.code == '405' ||
          e.message?.contains('service invalidated') == true) {
        _handleIOSNFCServiceError();
      } else {
        _setError('NFC error: ${e.message}');
      }
      debugPrint('[NFCViewModel] PlatformException: ${e.message}');
    } catch (e) {
      // iOS'ta "service invalidated" hatası için özel işlem
      if (e.toString().contains(
          'service named com.apple.nfcd.service.corenfc was invalidated')) {
        _handleIOSNFCServiceError();
      } else {
        _setError('An error occurred: $e');
      }
      debugPrint('[NFCViewModel] Error during NFC scan: $e');
    } finally {
      try {
        // Taramayı kapat
        await FlutterNfcKit.finish();
      } catch (e) {
        debugPrint('[NFCViewModel] Error closing NFC session: $e');
      }

      _isScanning = false;
      notifyListeners();
    }
  }

  /// iOS'taki NFC servis hatalarını özel olarak işler
  void _handleIOSNFCServiceError() {
    _setError('iOS NFC servis hatası. Lütfen şunları kontrol edin:\n'
        '1. Ekran kilidi açık olmalı\n'
        '2. Ayarlar > NFC izinleri verilmeli\n'
        '3. iPhone 7 veya daha yeni bir model kullanın');

    debugPrint('[NFCViewModel] iOS NFC service invalidated error handled');
  }

  /// NFC etiketinden okunan veriyi işler ve ProductModel'e dönüştürür
  Future<ProductModel?> _processTagData(NFCTag tag) async {
    try {
      // Tag ID'sini kullanarak ürünü Firebase'den getir
      final tagId = tag.id;
      final product = await _nfcProductService.getProductByNFCTagId(tagId);

      if (product != null) {
        debugPrint('[NFCViewModel] Product found in database: ${product.name}');
        return product;
      }

      // Veritabanında bulunamadıysa demo ürün oluştur
      debugPrint('[NFCViewModel] Creating demo product for tag ID: $tagId');
      return null;
    } catch (e) {
      debugPrint('[NFCViewModel] Error processing tag data: $e');
      return null;
    }
  }

  /// Hata mesajını ayarlar
  void _setError(String message) {
    _isError = true;
    _errorMessage = message;
    _isScanning = false;
    notifyListeners();
  }

  /// Tüm verileri sıfırlar
  void reset() {
    _isScanning = false;
    _isError = false;
    _errorMessage = null;
    _product = null;
    notifyListeners();
  }
}
