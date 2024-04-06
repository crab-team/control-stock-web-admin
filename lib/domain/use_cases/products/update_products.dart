import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProducts {
  final ProductsRepository _productsRepository;

  UpdateProducts(this._productsRepository);

  Future<Either<Failure, void>> execute(List<Product> products) async {
    return await _productsRepository.updateProducts(products);
  }
}
