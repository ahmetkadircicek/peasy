import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peasy/core/services/product/firestore_service_interface.dart';

class FirestoreService<T> implements FirestoreServiceInterface<T> {
  final String collectionPath;
  final T Function(Map<String, dynamic> data, String documentId) fromFirestore;
  final Map<String, dynamic> Function(T item) toFirestore;

  final CollectionReference<Map<String, dynamic>> collection;

  FirestoreService({
    required this.collectionPath,
    required this.fromFirestore,
    required this.toFirestore,
  }) : collection = FirebaseFirestore.instance.collection(collectionPath);

  @override
  Future<String> create(T item) async {
    final docRef = await collection.add(toFirestore(item));
    return docRef.id;
  }

  @override
  Future<void> update(String id, T item) async {
    await collection.doc(id).update(toFirestore(item));
  }

  @override
  Future<void> delete(String id) async {
    await collection.doc(id).delete();
  }

  @override
  Future<T?> getById(String id) async {
    final docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      return fromFirestore(docSnapshot.data()!, docSnapshot.id);
    }
    return null;
  }

  @override
  Future<List<T>> getAll() async {
    final querySnapshot = await collection.get();
    return querySnapshot.docs
        .map((doc) => fromFirestore(doc.data(), doc.id))
        .toList();
  }
}
