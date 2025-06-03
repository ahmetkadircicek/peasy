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
}
