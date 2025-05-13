// services/category_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peasy/features/home/model/category_model.dart';

class CategoryService {
  final CollectionReference _categoryCollection =
      FirebaseFirestore.instance.collection('Categories');

  Future<List<CategoryModel>> getAllCategories() async {
    final querySnapshot = await _categoryCollection.get();
    return querySnapshot.docs.map((doc) {
      return CategoryModel(
        id: doc.id,
        name: doc.get('name'),
      );
    }).toList();
  }

  Future<CategoryModel?> getCategoryById(String id) async {
    final docSnapshot = await _categoryCollection.doc(id).get();
    if (docSnapshot.exists) {
      return CategoryModel(
        id: docSnapshot.id,
        name: docSnapshot.get('name'),
      );
    }
    return null;
  }
}
