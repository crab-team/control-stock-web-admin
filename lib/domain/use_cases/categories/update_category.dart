import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateCategory {
  final CategoriesRepository repository;

  UpdateCategory(this.repository);

  Future<Either<AppError, void>> execute(Category category) async {
    return await repository.update(category);
  }
}
