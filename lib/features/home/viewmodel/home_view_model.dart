import 'package:flutter/material.dart';
import 'package:peasy/features/home/model/category_model.dart';
import 'package:peasy/features/home/model/section_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<SectionModel> _sections = [];
  List<SectionModel> get sections => _sections;

  HomeViewModel() {
    _fetchSections();
  }

  void _fetchSections() {
    _sections = [
      SectionModel(
        title: 'Fruits and Vegetables',
        categories: [
          CategoryModel(
            title: 'Fresh Fruits',
            imagePath: 'assets/images/dummy_category.png',
            description: 'Seasonal and exotic fruits for healthy snacking.',
          ),
          CategoryModel(
            title: 'Vegetables',
            imagePath: 'assets/images/dummy_category.png',
            description: 'Fresh and organic vegetables for your meals.',
          ),
          CategoryModel(
            title: 'Berries',
            imagePath: 'assets/images/dummy_category.png',
            description: 'Delicious and nutritious berries for a healthy diet.',
          ),
          CategoryModel(
            title: 'Citrus Fruits',
            imagePath: 'assets/images/dummy_category.png',
            description: 'Zesty citrus fruits packed with vitamin C.',
          ),
        ],
      ),
      SectionModel(
        title: 'Dairy Products',
        categories: [
          CategoryModel(
            title: 'Milk',
            imagePath: 'assets/images/dummy_category.png',
            description: 'Fresh and pure dairy milk for daily nutrition.',
          ),
          CategoryModel(
            title: 'Cheese',
            imagePath: 'assets/images/dummy_category.png',
            description: 'Varieties of cheese for every dish and snack.',
          ),
          CategoryModel(
            title: 'Yogurt',
            imagePath: 'assets/images/dummy_category.png',
            description: 'Healthy probiotic yogurt for digestion.',
          ),
        ],
      ),
      SectionModel(
        title: 'Dairy Products',
        categories: [
          CategoryModel(
            title: 'Milk',
            imagePath: 'assets/images/dummy_category.png',
            description: 'Fresh and pure dairy milk for daily nutrition.',
          ),
          CategoryModel(
            title: 'Cheese',
            imagePath: 'assets/images/dummy_category.png',
            description: 'Varieties of cheese for every dish and snack.',
          ),
          CategoryModel(
            title: 'Yogurt',
            imagePath: 'assets/images/dummy_category.png',
            description: 'Healthy probiotic yogurt for digestion.',
          ),
        ],
      ),
    ];
    notifyListeners();
  }
}
