import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteProduct {
  final ProductsRepository repository;

  DeleteProduct(this.repository);

  Future<Either<Failure, void>> execute(int id) async {
    return await repository.delete(id);
  }
}
