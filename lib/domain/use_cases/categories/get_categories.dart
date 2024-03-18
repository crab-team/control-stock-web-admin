import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategories {
  final CategoriesRepository _repository;

  GetCategories(this._repository);

  Future<Either<Failure, List<Category>>> execute() async {
    return await _repository.getAll();
  }
}
