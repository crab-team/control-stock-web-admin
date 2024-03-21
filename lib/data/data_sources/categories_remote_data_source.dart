import 'package:control_stock_web_admin/data/responses/category_response.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryResponse>> getCategories();
  Future<CategoryResponse> addCategory(String category);
  Future<CategoryResponse> updateCategory(Category category);
  Future<void> deleteCategory(String id);
}
