import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoriesRepository {
  Future<Either<AppError, List<Category>>> getAll();
  Future<Either<AppError, Category>> get(int id);
  Future<Either<AppError, Category>> create(String categoryName, double percentageProfit, double extraCosts);
  Future<Either<AppError, Category>> update(Category category);
  Future<Either<AppError, void>> delete(int id);
}
