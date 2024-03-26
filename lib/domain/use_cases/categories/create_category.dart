import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

class CreateCategory {
  final CategoriesRepository _repository;

  CreateCategory(this._repository);

  Future<Either<Failure, Category>> execute(String categoryName, double percentageProfit) async {
    return await _repository.create(categoryName, percentageProfit);
  }
}
