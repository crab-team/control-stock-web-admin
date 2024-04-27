import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteProduct {
  final ProductsRepository repository;

  DeleteProduct(this.repository);

  Future<Either<AppError, void>> execute(int id) async {
    return await repository.delete(id);
  }
}
