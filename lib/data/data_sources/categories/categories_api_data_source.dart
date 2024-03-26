import 'package:control_stock_web_admin/data/data_sources/categories/categories_remote_data_source.dart';
import 'package:control_stock_web_admin/data/responses/category_response.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:control_stock_web_admin/utils/logger.dart';

class CategoriesApiDataSource implements CategoriesRemoteDataSource {
  final APIClient apiClient;

  CategoriesApiDataSource(this.apiClient);
  String path = '/categories';

  @override
  Future<List<CategoryResponse>> getCategories() async {
    try {
      final response = await apiClient.sendGet(path);
      final List<CategoryResponse> categoriesResponse =
          (response as List).map((categoryResponse) => CategoryResponse.fromJson(categoryResponse)).toList();

      return categoriesResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<CategoryResponse> addCategory(String category, double percentageProfit) async {
    try {
      final body = {"name": category, "percentageProfit": percentageProfit};
      final response = await apiClient.sendPost(path, body: body);
      final categoryResponse = CategoryResponse.fromJson(response);
      return categoryResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<CategoryResponse> updateCategory(Category category) async {
    try {
      final response = await apiClient.sendPut('$path/${category.id}', body: category.toJson());
      final categoryResponse = CategoryResponse.fromJson(response);
      return categoryResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    try {
      await apiClient.sendDelete('$path/$id');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
