import 'package:flutter/material.dart';
import 'package:peasy/features/home/model/category_model.dart';
import 'package:peasy/features/home/model/subcategory_model.dart';
import 'package:peasy/features/home/service/category_service.dart';
import 'package:peasy/features/home/service/subcategory_service.dart';

class HomeViewModel extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  List<SubcategoryModel> _subcategories = [];
  List<CategoryModel> get categories => _categories;
  List<SubcategoryModel> get subcategories => _subcategories;

  HomeViewModel() {
    _fetchSections();
    _fetchSubcategories();
  }

  void _fetchSections() async {
    final categories = await CategoryService().getAllCategories();
    _categories = categories.map((category) {
      return CategoryModel(
        id: category.id,
        name: category.name,
      );
    }).toList();
    notifyListeners();
  }

  void _fetchSubcategories() async {
    final subcategories = await SubcategoryService().getAllSubcategories();
    _subcategories = subcategories.map((subcategory) {
      return SubcategoryModel(
        id: subcategory.id,
        categoryId: subcategory.categoryId,
        title: subcategory.title,
        imagePath: subcategory.imagePath,
        description: subcategory.description,
      );
    }).toList();
    notifyListeners();
  }

  List<SubcategoryModel> getSubcategoriesForCategory(String categoryId) {
    return _subcategories
        .where((subcategory) => subcategory.categoryId == categoryId)
        .toList();
  }
}
