import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateProduct {
  final ProductsRepository repository;

  UpdateProduct(this.repository);

  Future<Either<AppError, Product>> execute(Product product) async {
    return await repository.update(product);
  }
}
