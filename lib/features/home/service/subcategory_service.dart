import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peasy/features/home/model/subcategory_model.dart';

class SubcategoryService {
  final CollectionReference _subcategoryCollection =
      FirebaseFirestore.instance.collection('Subcategories');

  /// Tüm alt kategorileri getirir
  Future<List<SubcategoryModel>> getAllSubcategories() async {
    final querySnapshot = await _subcategoryCollection.get();

    return querySnapshot.docs.map((doc) {
      // Belge verilerini Map olarak alalım
      final data = doc.data() as Map<String, dynamic>? ?? {};

      return SubcategoryModel(
        id: doc.id,
        categoryId: data['categoryId']?.toString() ?? '',
        title: data['name'] ?? '',
        imagePath: data['imagePath'] ?? 'assets/images/dummy_category.png',
        description: data['description'] ?? '',
      );
    }).toList();
  }
}
