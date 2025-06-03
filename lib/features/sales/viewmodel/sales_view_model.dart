import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/coupon_model.dart';

class SalesViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<CouponModel> _coupons = [];
  List<CouponModel> get coupons => _coupons;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchCoupons() async {
    _isLoading = true;
    notifyListeners();

    try {
      final querySnapshot = await _firestore.collection('coupons').get();
      _coupons = querySnapshot.docs.map((doc) {
        return CouponModel.fromJson(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      debugPrint("Coupons verisi çekilirken hata oluştu: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
