import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCategories {
  final CategoriesRepository _repository;

  GetCategories(this._repository);

  Future<Either<AppError, List<Category>>> execute() async {
    return await _repository.getAll();
  }
}
