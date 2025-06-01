import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peasy/features/category/model/product_model.dart';

class NFCProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProductModel?> getProductByNFCTagId(String tagId) async {
    try {
      // 1. RFID koleksiyonundan rfidTag == tagId olan belgeyi bul
      final rfidSnapshot = await _firestore
          .collection('RFID')
          .where('rfidTag', isEqualTo: tagId)
          .limit(1)
          .get();

      if (rfidSnapshot.docs.isEmpty) {
        debugPrint('[NFCProductService] RFID tag not found: $tagId');
        return null;
      }

      // 2. RFID'deki productId'yi al
      final productId = rfidSnapshot.docs.first.get('productId');

      // 3. Products koleksiyonundan bu productId ile ürünü al
      final productSnapshot = await _firestore
          .collection('Products')
          .where('productId', isEqualTo: productId)
          .limit(1)
          .get();

      if (productSnapshot.docs.isEmpty) {
        debugPrint('[NFCProductService] Product not found for ID: $productId');
        return null;
      }

      // 4. Ürünü modelle ve dön
      final productData = productSnapshot.docs.first.data();
      return ProductModel.fromJson(productData);
    } catch (e) {
      debugPrint('[NFCProductService] Error: $e');
      return null;
    }
  }
}
