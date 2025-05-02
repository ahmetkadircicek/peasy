import 'package:flutter/cupertino.dart';
import 'package:peasy/features/cart/model/cart_model.dart';

class CartViewModel extends ChangeNotifier {
  List<CartModel> _cartItems = [];
  List<CartModel> get cartItems => _cartItems;

  CartViewModel() {
    fetchCartItems();
  }

  void fetchCartItems() {
    _cartItems = [
      CartModel(
        id: '00000001',
        imagePath: 'assets/images/product.png',
        name: 'Apple',
        price: 1.00,
        quantity: 1,
      ),
      CartModel(
        id: '00000002',
        imagePath: 'assets/images/product.png',
        name: 'Banana',
        price: 2.00,
        quantity: 2,
      ),
      CartModel(
        id: '00000003',
        imagePath: 'assets/images/product.png',
        name: 'Orange',
        price: 3.00,
        quantity: 3,
      ),
      CartModel(
        id: '00000004',
        imagePath: 'assets/images/product.png',
        name: 'Grapes',
        price: 4.00,
        quantity: 4,
      ),
      CartModel(
        id: '00000005',
        imagePath: 'assets/images/product.png',
        name: 'Mango',
        price: 5.00,
        quantity: 5,
      ),
      CartModel(
        id: '00000006',
        imagePath: 'assets/images/product.png',
        name: 'Pineapple',
        price: 6.00,
        quantity: 6,
      ),
      CartModel(
        id: '00000007',
        imagePath: 'assets/images/product.png',
        name: 'Strawberry',
        price: 7.00,
        quantity: 7,
      ),
      CartModel(
        id: '00000008',
        imagePath: 'assets/images/product.png',
        name: 'Watermelon',
        price: 8.00,
        quantity: 8,
      ),
      CartModel(
        id: '00000009',
        imagePath: 'assets/images/product.png',
        name: 'Blueberry',
        price: 9.00,
        quantity: 9,
      ),
      CartModel(
        id: '00000010',
        imagePath: 'assets/images/product.png',
        name: 'Raspberry',
        price: 10.00,
        quantity: 10,
      ),
      CartModel(
        id: '00000011',
        imagePath: 'assets/images/product.png',
        name: 'Blackberry',
        price: 11.00,
        quantity: 11,
      ),
      CartModel(
        id: '00000012',
        imagePath: 'assets/images/product.png',
        name: 'Peach',
        price: 12.00,
        quantity: 12,
      ),
    ];
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
