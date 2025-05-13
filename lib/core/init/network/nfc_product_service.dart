import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peasy/features/category/model/product_model.dart';

class NFCProductService {
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('Products');

  /// NFC Tag ID'sine göre ürünü getirir
  Future<ProductModel?> getProductByNFCTagId(String tagId) async {
    try {
      final querySnapshot = await _productCollection
          .where('nfcTagId', isEqualTo: tagId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      final doc = querySnapshot.docs.first;
      final data = doc.data() as Map<String, dynamic>? ?? {};

      return ProductModel.fromJson(data);
    } catch (e) {
      print('Error fetching product by NFC tag ID: $e');
      return null;
    }
  }
}
