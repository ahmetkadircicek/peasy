// services/category_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:peasy/features/home/model/category_model.dart';

class CategoryService {
  final CollectionReference _categoryCollection =
      FirebaseFirestore.instance.collection('Categories');

  Future<List<CategoryModel>> getAllCategories() async {
    debugPrint('[CategoryService] Fetching all categories...');
    await Future.delayed(const Duration(seconds: 3));
    try {
      final querySnapshot = await _categoryCollection.get();
      return querySnapshot.docs.map((doc) {
        return CategoryModel(
          id: doc.id,
          name: doc.get('name'),
        );
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoryModel?> getCategoryById(String categoryId) async {
    final doc = await _categoryCollection.doc(categoryId).get();
    if (doc.exists) {
      return CategoryModel(
        id: doc.id,
        name: doc.get('name'),
      );
    }
    return null;
  }
}
