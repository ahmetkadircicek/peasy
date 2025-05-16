import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peasy/features/cart/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartViewModel extends ChangeNotifier {
  List<CartModel> _cartItems = [];
  List<CartModel> get cartItems => _cartItems;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  // Sepet özeti bilgileri
  int get itemCount => _cartItems.length;
  int get totalItems => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.18;
  double get shipping => subtotal > 100 ? 0 : 10;
  double get total => subtotal + tax + shipping;

  // Kategoriye göre gruplandırılmış ürünler
  Map<String, List<CartModel>> get groupedItems {
    final Map<String, List<CartModel>> grouped = {};

    for (var item in _cartItems) {
      final category = item.category ?? 'Diğer';
      if (!grouped.containsKey(category)) {
        grouped[category] = [];
      }
      grouped[category]!.add(item);
    }

    return grouped;
  }

  // Constructor ile ürün ekleyebilme
  CartViewModel({List<CartModel>? initialItems}) {
    if (initialItems != null && initialItems.isNotEmpty) {
      _addInitialItems(initialItems);
    } else {
      loadCartItems();
    }
  }

  // Constructor ile gelen ürünleri ekle
  void _addInitialItems(List<CartModel> items) async {
    _setLoading(true);

    // Mevcut sepeti yükle
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString('cart');

      if (cartData != null) {
        final List<dynamic> decodedData = jsonDecode(cartData);
        _cartItems =
            decodedData.map((item) => CartModel.fromJson(item)).toList();
      } else {
        _cartItems = [];
      }

      // Yeni ürünleri ekle
      for (var item in items) {
        addItem(item);
      }
    } catch (e) {
      debugPrint('Sepet yüklenirken hata: $e');

      // Hata durumunda doğrudan ekle
      _cartItems = List.from(items);
      _saveCartItems();
    }

    _setLoading(false);
  }

  // Sepet durumunu genişlet/daralt
  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  // Sepeti yükle
  Future<void> loadCartItems() async {
    _setLoading(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString('cart');

      if (cartData != null) {
        final List<dynamic> decodedData = jsonDecode(cartData);
        _cartItems =
            decodedData.map((item) => CartModel.fromJson(item)).toList();
      } else {
        // Demo veriler (gerçek uygulamada kaldırılacak)
        _loadDemoItems();
      }
    } catch (e) {
      debugPrint('Sepet yüklenirken hata: $e');
      _loadDemoItems();
    }

    _setLoading(false);
  }

  // Sepeti kaydet
  Future<void> _saveCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData =
          jsonEncode(_cartItems.map((item) => item.toJson()).toList());
      await prefs.setString('cart', cartData);
    } catch (e) {
      debugPrint('Sepet kaydedilirken hata: $e');
    }
  }

  // Ürün ekle
  void addItem(CartModel item) {
    final existingItemIndex =
        _cartItems.indexWhere((cartItem) => cartItem.id == item.id);

    if (existingItemIndex >= 0) {
      // Ürün zaten sepette, miktarı artır
      _cartItems[existingItemIndex].incrementQuantity();
    } else {
      // Yeni ürün ekle
      _cartItems.add(item);
    }

    _saveCartItems();
    notifyListeners();
  }

  // Ürün miktarını artır
  void incrementQuantity(String itemId) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      _cartItems[index].incrementQuantity();
      _saveCartItems();
      notifyListeners();
    }
  }

  // Ürün miktarını azalt
  void decrementQuantity(String itemId) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].decrementQuantity();
      } else {
        // Miktar 1'e düştüyse ürünü kaldır
        removeItem(itemId);
        return;
      }
      _saveCartItems();
      notifyListeners();
    }
  }

  // Ürünü kaldır
  void removeItem(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    _saveCartItems();
    notifyListeners();
  }

  // Sepeti temizle
  void clearCart() {
    _cartItems.clear();
    _saveCartItems();
    notifyListeners();
  }

  // Yükleme durumunu ayarla
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Demo veriler (gerçek uygulamada kaldırılacak)
  void _loadDemoItems() {
    _cartItems = [
      CartModel(
        id: '1',
        imagePath: 'assets/images/product.png',
        name: 'Organik Elma',
        price: 12.90,
        quantity: 2,
        category: 'Meyve & Sebze',
        description: 'Taze organik elma, kg başına fiyat',
      ),
      CartModel(
        id: '2',
        imagePath: 'assets/images/product.png',
        name: 'Tam Yağlı Süt',
        price: 15.50,
        quantity: 1,
        category: 'Süt Ürünleri',
        description: '1 litre kutu süt',
      ),
      CartModel(
        id: '3',
        imagePath: 'assets/images/product.png',
        name: 'Tam Buğday Ekmeği',
        price: 8.75,
        quantity: 1,
        category: 'Fırın Ürünleri',
        description: '500g tam buğday ekmeği',
      ),
      CartModel(
        id: '4',
        imagePath: 'assets/images/product.png',
        name: 'Zeytinyağı',
        price: 120.00,
        quantity: 1,
        category: 'Yağ & Sos',
        description: '1 litre sızma zeytinyağı',
      ),
    ];
  }
}
