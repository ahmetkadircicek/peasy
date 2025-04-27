import 'package:flutter/material.dart';
import 'package:peasy/core/constants/enums/product_status_enum.dart';
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
        stockStatus: ProductStatusEnum.inStock,
        price: '1.00',
      ),
      ProductModel(
        id: '00000002',
        name: 'Banana',
        section: 'A2',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.outOfStock,
        price: '2.00',
      ),
      ProductModel(
        id: '00000003',
        name: 'Carrot',
        section: 'A3',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '3.00',
      ),
      ProductModel(
        id: '00000004',
        name: 'Milk',
        section: 'B1',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '4.00',
      ),
      ProductModel(
        id: '00000005',
        name: 'Bread',
        section: 'B2',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '5.00',
      ),
      ProductModel(
        id: '00000006',
        name: 'Eggs',
        section: 'B3',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '6.00',
      ),
      ProductModel(
        id: '00000007',
        name: 'Cheese',
        section: 'C1',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.outOfStock,
        price: '7.00',
      ),
      ProductModel(
        id: '00000008',
        name: 'Tomato',
        section: 'C2',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '8.00',
      ),
      ProductModel(
        id: '00000009',
        name: 'Potato',
        section: 'C3',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '9.00',
      ),
      ProductModel(
        id: '00000010',
        name: 'Onion',
        section: 'D1',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '10.00',
      ),
      ProductModel(
        id: '00000011',
        name: 'Garlic',
        section: 'D2',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '11.00',
      ),
      ProductModel(
        id: '00000012',
        name: 'Ginger',
        section: 'D3',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.outOfStock,
        price: '12.00',
      ),
      ProductModel(
        id: '00000013',
        name: 'Orange',
        section: 'E1',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '13.00',
      ),
      ProductModel(
        id: '00000014',
        name: 'Pineapple',
        section: 'E2',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '14.00',
      ),
      ProductModel(
        id: '00000015',
        name: 'Strawberry',
        section: 'E3',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '15.00',
      ),
      ProductModel(
        id: '00000016',
        name: 'Blueberry',
        section: 'F1',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.outOfStock,
        price: '16.00',
      ),
      ProductModel(
        id: '00000017',
        name: 'Peach',
        section: 'F2',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '17.00',
      ),
      ProductModel(
        id: '00000018',
        name: 'Watermelon',
        section: 'F3',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '18.00',
      ),
      ProductModel(
        id: '00000019',
        name: 'Lettuce',
        section: 'G1',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '19.00',
      ),
      ProductModel(
        id: '00000020',
        name: 'Spinach',
        section: 'G2',
        imagePath: 'assets/images/product.png',
        stockStatus: ProductStatusEnum.inStock,
        price: '20.00',
      ),
    ];
    notifyListeners();
  }
}
