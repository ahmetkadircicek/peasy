import 'package:flutter/material.dart';
import 'package:peasy/features/category/model/product_model.dart';

class CategoryViewModel extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  CategoryViewModel() {
    _fetchProducts();
  }

  // Method to fetch products
  void _fetchProducts() {
    _products = [
      ProductModel(
        id: '00000001',
        name: 'Apple',
        section: 'A1',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000002',
        name: 'Banana',
        section: 'A2',
        imagePath: 'assets/images/product.png',
        stockStatus: 'Out of Stock',
      ),
      ProductModel(
        id: '00000003',
        name: 'Carrot',
        section: 'A3',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000004',
        name: 'Milk',
        section: 'B1',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000005',
        name: 'Bread',
        section: 'B2',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000006',
        name: 'Eggs',
        section: 'B3',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000007',
        name: 'Cheese',
        section: 'C1',
        imagePath: 'assets/images/product.png',
        stockStatus: 'Out of Stock',
      ),
      ProductModel(
        id: '00000008',
        name: 'Tomato',
        section: 'C2',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000009',
        name: 'Potato',
        section: 'C3',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000010',
        name: 'Onion',
        section: 'D1',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000011',
        name: 'Garlic',
        section: 'D2',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000012',
        name: 'Ginger',
        section: 'D3',
        imagePath: 'assets/images/product.png',
        stockStatus: 'Out of Stock',
      ),
      ProductModel(
        id: '00000013',
        name: 'Orange',
        section: 'E1',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000014',
        name: 'Pineapple',
        section: 'E2',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000015',
        name: 'Strawberry',
        section: 'E3',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000016',
        name: 'Blueberry',
        section: 'F1',
        imagePath: 'assets/images/product.png',
        stockStatus: 'Out of Stock',
      ),
      ProductModel(
        id: '00000017',
        name: 'Peach',
        section: 'F2',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000018',
        name: 'Watermelon',
        section: 'F3',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000019',
        name: 'Lettuce',
        section: 'G1',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
      ProductModel(
        id: '00000020',
        name: 'Spinach',
        section: 'G2',
        imagePath: 'assets/images/product.png',
        stockStatus: 'In Stock',
      ),
    ];
    notifyListeners();
  }
}
