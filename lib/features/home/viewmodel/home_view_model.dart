import 'package:flutter/material.dart';
import 'package:peasy/core/init/network/category_service.dart';
import 'package:peasy/core/init/network/subcategory_service.dart';
import 'package:peasy/features/home/model/category_model.dart';
import 'package:peasy/features/home/model/subcategory_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  List<SubcategoryModel> _subcategories = [];
  bool _isLoading = false;

  List<CategoryModel> get categories => _categories;
  List<SubcategoryModel> get subcategories => _subcategories;
  bool get isLoading => _isLoading;

  HomeViewModel() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    _setLoading(true);
    await Future.wait([
      _fetchSections(),
      _fetchSubcategories(),
    ]);
    _setLoading(false);
  }

  Future<void> _fetchSections() async {
    final categories = await CategoryService().getAllCategories();
    _categories = categories;
    notifyListeners();
  }

  Future<void> _fetchSubcategories() async {
    final subcategories = await SubcategoryService().getAllSubcategories();
    _subcategories = subcategories;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<SubcategoryModel> getSubcategoriesForCategory(String categoryId) {
    return _subcategories
        .where((subcategory) => subcategory.categoryId == categoryId)
        .toList();
  }
}
