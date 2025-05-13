import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peasy/features/category/model/product_model.dart';

class ProductService {
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('Products');

  Future<List<ProductModel>> getProducts({
    String? categoryId,
    String? subcategoryId,
  }) async {
    try {
      Query query = _productCollection;

      if (categoryId != null) {
        query = query.where('categoryId', isEqualTo: int.parse(categoryId));
      }
      if (subcategoryId != null) {
        query =
            query.where('subcategoryId', isEqualTo: int.parse(subcategoryId));
      }

      final querySnapshot = await query.get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>? ?? {};
        return ProductModel.fromJson(data);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
