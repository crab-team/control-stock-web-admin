import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/categories/categories_remote_data_source.dart';
import 'package:control_stock_web_admin/data/responses/category_response.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:fpdart/fpdart.dart';

class CategoriesApiDataSource implements CategoriesRemoteDataSource {
  final APIClient apiClient;

  CategoriesApiDataSource(this.apiClient);
  String path = '/commerces/1/categories';

  @override
  Future<Either<AppError, List<CategoryResponse>>> getCategories() async {
    final response = await apiClient.sendGet(path);
    return response.fold((l) => throw l, (r) {
      final List<CategoryResponse> categoriesResponse =
          (r as List).map((categoryResponse) => CategoryResponse.fromJson(categoryResponse)).toList();
      return Right(categoriesResponse);
    });
  }

  @override
  Future<Either<AppError, CategoryResponse>> addCategory(
      String category, double percentageProfit, double extraCosts) async {
    final body = {"name": category, "percentageProfit": percentageProfit, "extraCosts": extraCosts};
    final response = await apiClient.sendPost(path, body: body);
    return response.fold((l) => Left(l), (r) => Right(CategoryResponse.fromJson(r)));
  }

  @override
  Future<Either<AppError, CategoryResponse>> updateCategory(Category category) async {
    final response = await apiClient.sendPut('$path/${category.id}', body: category.toJson());
    return response.fold((l) => Left(l), (r) => Right(CategoryResponse.fromJson(r)));
  }

  @override
  Future<Either<AppError, void>> deleteCategory(int id) async {
    final response = await apiClient.sendDelete('$path/$id');
    return response.fold((l) => throw l, (r) => r);
  }
}
