import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductsRepository {
  Future<Either<AppError, List<Product>>> getAll();
  Future<Either<AppError, Product>> get(int id);
  Future<Either<AppError, Product>> create(Product product);
  Future<Either<AppError, void>> createProducts(List<Product> products);
  Future<Either<AppError, Product>> update(Product product);
  Future<Either<AppError, void>> updateProducts(List<Product> products);
  Future<Either<AppError, void>> adjustPricesByCategory(int categoryId, double adjust);
  Future<Either<AppError, void>> delete(int id);
}
