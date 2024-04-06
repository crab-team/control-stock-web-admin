import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getAll();
  Future<Either<Failure, Product>> get(int id);
  Future<Either<Failure, Product>> create(Product product);
  Future<Either<Failure, void>> createProducts(List<Product> products);
  Future<Either<Failure, Product>> update(Product product);
  Future<Either<Failure, void>> updateProducts(List<Product> products);
  Future<Either<Failure, void>> delete(int id);
}
