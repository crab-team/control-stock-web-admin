import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class CreateProduct {
  final ProductsRepository repository;

  CreateProduct(this.repository);

  Future<Either<Failure, Product>> execute(Product product) async {
    return await repository.create(product);
  }
}
