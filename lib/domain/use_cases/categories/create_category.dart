import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateCategory {
  final CategoriesRepository _repository;

  CreateCategory(this._repository);

  Future<Either<AppError, Category>> execute(String categoryName, double percentageProfit, double extraCosts) async {
    return await _repository.create(categoryName, percentageProfit, extraCosts);
  }
}
