import 'package:control_stock_web_admin/data/responses/category_response.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryResponse>> getCategories();
}
