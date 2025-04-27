abstract class FirestoreServiceInterface<T> {
  Future<String> create(T item);
  Future<void> update(String id, T item);
  Future<void> delete(String id);
  Future<T?> getById(String id);
  Future<List<T>> getAll();
}
