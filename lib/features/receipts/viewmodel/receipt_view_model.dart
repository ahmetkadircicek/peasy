import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/order_model.dart';

class ReceiptViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<OrderModel> orders = [];
  bool isLoading = true;

  Future<void> fetchUserOrders() async {
    try {
      isLoading = true;
      notifyListeners();

      final user = _auth.currentUser;
      if (user == null) {
        orders = [];
        isLoading = false;
        notifyListeners();
        return;
      }

      final querySnapshot = await _firestore
          .collection('completedOrders')
          .where('customerId', isEqualTo: user.uid)
          .get();

      orders = querySnapshot.docs.map((doc) {
        return OrderModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      print("Siparişler çekilirken hata oluştu: $e");
      orders = [];
    }

    isLoading = false;
    notifyListeners();
  }

  // Ürün detaylarını siparişler için çekme
  Future<void> getProductDetailsForOrders() async {
    try {
      for (var order in orders) {
        List<OrderItem> updatedItems = [];
        for (var item in order.orderItems) {
          final productDoc =
              await _firestore.collection('products').doc(item.productId).get();
          if (productDoc.exists) {
            final productData = productDoc.data()!;
            updatedItems
                .add(OrderItem.fromRawMap(item.toRawMap(), productData));
          }
        }
        order = order.copyWith(orderItems: updatedItems);
      }
    } catch (e) {
      print("Ürün detayları alınırken hata oluştu: $e");
    }
  }
}
