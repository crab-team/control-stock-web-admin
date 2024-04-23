import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<Category>>> getAll();
  Future<Either<Failure, Category>> get(int id);
  Future<Either<Failure, Category>> create(String categoryName, double percentageProfit, double extraCosts);
  Future<Either<Failure, Category>> update(Category category);
  Future<Either<Failure, void>> delete(int id);
}
