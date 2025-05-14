import 'package:flutter/material.dart';
import 'package:peasy/core/init/network/product_service.dart';
import 'package:peasy/features/category/model/product_model.dart';
import 'package:peasy/features/home/model/subcategory_model.dart';
import 'package:peasy/features/home/service/subcategory_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  final SubcategoryService _subcategoryService = SubcategoryService();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  // Alt kategoriler listesi
  List<SubcategoryModel> _subcategories = [];
  List<SubcategoryModel> get subcategories => _subcategories;

  // Mevcut kategori ID'si
  String? _currentCategoryId;
  String? get currentCategoryId => _currentCategoryId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingSubcategories = false;
  bool get isLoadingSubcategories => _isLoadingSubcategories;

  // Ürünleri kategorilere göre gruplayacak map
  Map<String, List<ProductModel>> _categorizedProducts = {};
  Map<String, List<ProductModel>> get categorizedProducts =>
      _categorizedProducts;

  // Alt kategori ID'si
  String? _selectedSubcategoryId;
  String? get selectedSubcategoryId => _selectedSubcategoryId;

  // Alt kategori isimlerini tutan map
  final Map<String, String> _subcategoryNames = {};
  Map<String, String> get subcategoryNames => _subcategoryNames;

  // Seçili alt kategori adını döndür
  String? get selectedSubcategoryName {
    if (_selectedSubcategoryId == null) return null;

    final selectedSubcategory = _subcategories.firstWhere(
      (sub) => sub.id == _selectedSubcategoryId,
      orElse: () => SubcategoryModel(
          id: "", categoryId: "", title: "", imagePath: "", description: ""),
    );

    return selectedSubcategory.title.isNotEmpty
        ? selectedSubcategory.title
        : null;
  }

  /// Belirli bir kategoriye ait ürünleri ve alt kategorileri getirir
  Future<void> loadCategoryData(String categoryId,
      {String? subcategoryId}) async {
    _currentCategoryId = categoryId;

    // Kategori ürünlerini yükle
    await fetchProductsByCategoryId(categoryId);

    // Alt kategorileri yükle
    await loadSubcategories(categoryId);

    // Eğer bir alt kategori ID'si belirtilmişse, o alt kategoriye göre filtrele
    if (subcategoryId != null) {
      await filterProductsBySubcategory(subcategoryId);
    }
  }

  /// Kategoriye ait alt kategorileri yükler
  Future<void> loadSubcategories(String categoryId) async {
    _setLoadingSubcategories(true);

    try {
      final allSubcategories = await _subcategoryService.getAllSubcategories();

      // Kategori ID'sine göre filtrele
      _subcategories = allSubcategories
          .where((sub) => sub.categoryId == categoryId)
          .toList();

      // Alt kategori adlarını mapleyelim
      for (var sub in _subcategories) {
        _subcategoryNames[sub.id] = sub.title;
      }
    } catch (e) {
      _subcategories = [];
    }

    _setLoadingSubcategories(false);
  }

  /// Belirli bir kategoriye ait ürünleri getirir
  Future<void> fetchProductsByCategoryId(String categoryId) async {
    _setLoading(true);
    _selectedSubcategoryId = null; // Alt kategori seçimi sıfırlanıyor
    _currentCategoryId = categoryId; // Kategorinin ID'sini kaydet

    try {
      _products = await _productService.getProducts(categoryId: categoryId);
      _categorizeProducts();
    } catch (e) {
      _products = [];
      _categorizedProducts = {};
      notifyListeners();
    }
    _setLoading(false);
  }

  /// Belirli bir alt kategoriye ait ürünleri filtreler
  Future<void> filterProductsBySubcategory(String subcategoryId) async {
    _setLoading(true);
    _selectedSubcategoryId = subcategoryId;

    try {
      // Eğer mevcut kategori ID'si varsa, o kategori ve alt kategori için ürünleri al
      if (_currentCategoryId != null) {
        _products = await _productService.getProducts(
          categoryId: _currentCategoryId,
          subcategoryId: subcategoryId,
        );
        // Ürün yoksa ve alt kategori ID'si varsa, Firestore'dan doğrudan alt kategoriye göre filtreleyelim
        if (_products.isEmpty) {
          _products =
              await _productService.getProducts(subcategoryId: subcategoryId);
        }
      } else {
        _products =
            await _productService.getProducts(subcategoryId: subcategoryId);
      }
    } catch (e, stack) {
      _products = [];
      _categorizedProducts = {};
      notifyListeners();
    }

    _setLoading(false);
  }

  /// Ürünleri kategorilere göre gruplar
  void _categorizeProducts() {
    _categorizedProducts = {};

    // Ürün yoksa, boş map döndür
    if (_products.isEmpty) {
      notifyListeners();
      return;
    }

    // Alt kategori seçilmişse ve o alt kategoriye ait ürünler varsa
    if (_selectedSubcategoryId != null) {
      // Seçilen alt kategoriye ait ürünleri filtrele
      final filteredProducts = _products
          .where((product) => product.subcategoryId == _selectedSubcategoryId)
          .toList();

      // Eğer filtrelenmiş ürünler varsa, onları göster
      if (filteredProducts.isNotEmpty) {
        _categorizedProducts[_selectedSubcategoryId!] = filteredProducts;
      } else {
        // Eğer filtrelenmiş ürün yoksa, section değerini kontrol etmeden tüm ürünleri göster
        _categorizedProducts["products"] = _products;
      }
    } else {
      // Alt kategori seçilmemişse, section'a göre ürünleri grupla
      _categorizeProductsBySection();
    }

    notifyListeners();
  }

  /// Ürünleri section'lara göre gruplar
  void _categorizeProductsBySection() {
    // Section'a göre gruplandır
    final sectionGroups = <String, List<ProductModel>>{};

    for (var product in _products) {
      final section = product.subcategoryId.toString();

      if (!sectionGroups.containsKey(section)) {
        sectionGroups[section] = [];
      }

      sectionGroups[section]!.add(product);
    }

    // Eğer section'a göre gruplandırılmış ürün yoksa, tümünü "products" altında göster
    if (sectionGroups.isEmpty) {
      _categorizedProducts["products"] = _products;
    } else {
      _categorizedProducts = sectionGroups;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setLoadingSubcategories(bool value) {
    _isLoadingSubcategories = value;
    notifyListeners();
  }

  String getSubcategoryName(String subcategoryId) {
    return _subcategoryNames[subcategoryId] ?? 'Products';
  }
}
