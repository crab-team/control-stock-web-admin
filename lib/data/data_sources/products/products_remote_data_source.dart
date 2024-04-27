import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/models/product_model.dart';
import 'package:control_stock_web_admin/data/responses/product_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductsRemoteDataSource {
  Future<Either<AppError, List<ProductResponse>>> getAll();
  Future<Either<AppError, ProductResponse>> add(ProductModel product);
  Future<Either<AppError, void>> addProducts(List<ProductModel> products);
  Future<Either<AppError, ProductResponse>> update(ProductModel product);
  Future<Either<AppError, void>> updateProducts(List<ProductModel> products);
  Future<Either<AppError, void>> delete(int id);
}
