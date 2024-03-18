import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCategory {
  final CategoriesRepository _repository;

  DeleteCategory(this._repository);

  Future<Either<Failure, void>> execute(String id) async {
    return await _repository.delete(id);
  }
}
