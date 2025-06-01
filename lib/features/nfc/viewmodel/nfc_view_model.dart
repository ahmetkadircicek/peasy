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
    _resetStateBeforeScan();
    notifyListeners();

    try {
      final availability = await FlutterNfcKit.nfcAvailability;
      if (availability != NFCAvailability.available) {
        _setError('Bu cihazda NFC desteklenmiyor.');
        return;
      }

      debugPrint('[NFCViewModel] NFC tarama başlatılıyor...');
      final tag = await FlutterNfcKit.poll(
        timeout: const Duration(seconds: 20),
        iosMultipleTagMessage: 'Lütfen yalnızca bir etiketi okutun',
        iosAlertMessage: 'NFC etiketi okutmak için cihazı yaklaştırın',
      );

      debugPrint('[NFCViewModel] NFC etiketi bulundu: ${tag.id}');

      final productData = await _processTagData(tag);
      if (productData != null) {
        _product = productData;
        _isError = false;
        _errorMessage = null;
      } else {
        _setError('Etiket ile eşleşen ürün bulunamadı.');
      }
    } on PlatformException catch (e) {
      if (e.code == 'timeout') {
        _setError('Tarama zaman aşımına uğradı.');
      } else if (e.code == '405' ||
          e.message?.contains('service invalidated') == true) {
        _handleIOSNFCServiceError();
      } else {
        _setError('Platform hatası: ${e.message}');
      }
    } catch (e) {
      if (e.toString().contains(
          'service named com.apple.nfcd.service.corenfc was invalidated')) {
        _handleIOSNFCServiceError();
      } else {
        _setError('NFC işlemi sırasında hata oluştu: $e');
      }
    } finally {
      try {
        await FlutterNfcKit.finish();
      } catch (e) {
        debugPrint('[NFCViewModel] NFC oturumu kapatılamadı: $e');
      }
      _isScanning = false;
      notifyListeners();
    }
  }

  /// iOS NFC servis hataları için özel mesaj
  void _handleIOSNFCServiceError() {
    _setError('iOS NFC servis hatası. Lütfen:\n'
        '1. Ekran kilidini açık tutun\n'
        '2. Ayarlardan NFC izinlerini kontrol edin\n'
        '3. Uyumlu bir iPhone modeli kullanın');
    debugPrint('[NFCViewModel] iOS NFC service invalidated handled.');
  }

  /// NFC etiketi işleme
  Future<ProductModel?> _processTagData(NFCTag tag) async {
    try {
      final tagId = tag.id;
      final product = await _nfcProductService.getProductByNFCTagId(tagId);
      if (product != null) {
        debugPrint('[NFCViewModel] Ürün bulundu: ${product.name}');
      }
      return product;
    } catch (e) {
      debugPrint('[NFCViewModel] Etiket verisi işlenemedi: $e');
      return null;
    }
  }

  /// Hata durumunu ayarla
  void _setError(String message) {
    _isError = true;
    _errorMessage = message;
    _isScanning = false;
    notifyListeners();
  }

  /// Tarama öncesi state sıfırlama
  void _resetStateBeforeScan() {
    _isScanning = true;
    _isError = false;
    _errorMessage = null;
    _product = null;
  }

  /// Durumu sıfırlar
  void reset() {
    _resetStateBeforeScan();
    _isScanning = false;
    notifyListeners();
  }
}
