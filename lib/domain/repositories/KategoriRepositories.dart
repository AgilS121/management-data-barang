abstract class ICategoryRepository {
  Future<void> addCategory(String category);
  Stream<List<String>> getAllCategories();
}
