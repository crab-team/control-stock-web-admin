import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCategory {
  final CategoriesRepository repository;

  UpdateCategory(this.repository);

  Future<Either<Failure, void>> call(Category category) async {
    return await repository.update(category);
  }
}
