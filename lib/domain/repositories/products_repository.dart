import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getAll();
  Future<Either<Failure, Product>> get(String id);
  Future<Either<Failure, Product>> create(Product product);
  Future<Either<Failure, Product>> update(Product product);
  Future<Either<Failure, Product>> delete(String id);
}
