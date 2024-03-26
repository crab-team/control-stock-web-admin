import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class GetProduct {
  final ProductsRepository repository;

  GetProduct(this.repository);

  Future<Either<Failure, Product>> call(int id) async {
    return await repository.get(id);
  }
}
