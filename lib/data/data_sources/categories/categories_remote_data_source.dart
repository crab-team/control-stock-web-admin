import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/responses/category_response.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoriesRemoteDataSource {
  Future<Either<AppError, List<CategoryResponse>>> getCategories();
  Future<Either<AppError, CategoryResponse>> addCategory(String category, double percentageProfit, double extraCosts);
  Future<Either<AppError, CategoryResponse>> updateCategory(Category category);
  Future<Either<AppError, void>> deleteCategory(int id);
}
