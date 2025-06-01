import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peasy/core/init/network/category_service.dart';
import 'package:peasy/features/cart/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartViewModel extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  List<CartModel> _cartItems = [];
  List<CartModel> get cartItems => _cartItems;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  // Sepet bilgileri (özet)
  int get itemCount => _cartItems.length;
  int get totalItems => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.18;
  double get shipping => subtotal > 100 ? 0 : 10;
  double get total => subtotal + tax + shipping;

  // Ürünleri kategori bazında gruplandır
  Map<String, List<CartModel>> get groupedItems {
    final Map<String, List<CartModel>> grouped = {};
    for (var item in _cartItems) {
      final category = item.categoryName ?? 'Diğer';
      grouped.putIfAbsent(category, () => []);
    }
    return grouped;
  }

  // Constructor: Başlangıç ürünleri varsa ekle, yoksa önbellekten yükle
  CartViewModel({List<CartModel>? initialItems}) {
    if (initialItems != null && initialItems.isNotEmpty) {
      _addInitialItems(initialItems);
    } else {
      loadCartItems();
    }
  }

  /// 🔥 Yeni: CartModel'lere categoryName eşlemesi yap
  Future<void> enrichCartItemsWithCategoryNames() async {
    for (var item in _cartItems) {
      if (item.categoryName == null && item.categoryId != null) {
        final category =
            await _categoryService.getCategoryById(item.categoryId!.toString());
        item.categoryName = category?.name ?? 'Diğer';
      }
    }
    notifyListeners();
  }

  // Başlangıç ürünlerini ekle
  Future<void> _addInitialItems(List<CartModel> items) async {
    _setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString('cart');
      if (cartData != null) {
        final List<dynamic> decoded = jsonDecode(cartData);
        _cartItems = decoded.map((e) => CartModel.fromJson(e)).toList();
      } else {
        _cartItems = [];
      }
      for (var item in items) {
        addItem(item);
      }
    } catch (e) {
      debugPrint('Sepet yüklenirken hata: $e');
      _cartItems = List.from(items);
      await _saveCartItems();
    }
    _setLoading(false);
  }

  // Sepet görünümünü genişlet/daralt
  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  // Sepet ürünlerini SharedPreferences'tan yükle
  Future<void> loadCartItems() async {
    _setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString('cart');
      if (cartData != null) {
        final List<dynamic> decoded = jsonDecode(cartData);
        _cartItems = decoded.map((e) => CartModel.fromJson(e)).toList();
      } else {
        _cartItems = [];
      }
    } catch (e) {
      debugPrint('Sepet yüklenirken hata: $e');
      _cartItems = [];
    }
    _setLoading(false);
  }

  // Sepeti SharedPreferences'a kaydet
  Future<void> _saveCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encoded =
          jsonEncode(_cartItems.map((e) => e.toJson()).toList());
      await prefs.setString('cart', encoded);
    } catch (e) {
      debugPrint('Sepet kaydedilirken hata: $e');
    }
  }

  // Sepete ürün ekle (aynı ürün varsa tekrar eklenmez)
  void addItem(CartModel item) {
    final exists =
        _cartItems.any((element) => element.productId == item.productId);
    if (!exists) {
      _cartItems.add(item);
      _saveCartItems();
      notifyListeners();
    }
  }

  // Sepetten ürün çıkar (id'ye göre)
  void removeItem(String productId) {
    _cartItems.removeWhere((item) => item.productId == productId);
    _saveCartItems();
    notifyListeners();
  }

  // Sepeti tamamen temizle
  void clearCart() {
    _cartItems.clear();
    _saveCartItems();
    notifyListeners();
  }

  // Yükleme durumunu ayarla ve dinleyicilere bildir
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
