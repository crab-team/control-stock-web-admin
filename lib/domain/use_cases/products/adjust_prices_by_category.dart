import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

class ApplyAdjustCategory {
  final ProductsRepository _repository;

  ApplyAdjustCategory(this._repository);

  Future<Either<AppError, void>> call(int categoryId, double percentage) async {
    return await _repository.adjustPricesByCategory(categoryId, percentage);
  }
}
