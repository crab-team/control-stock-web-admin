import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetProduct {
  final ProductsRepository repository;

  GetProduct(this.repository);

  Future<Either<AppError, Product>> call(int id) async {
    return await repository.get(id);
  }
}
