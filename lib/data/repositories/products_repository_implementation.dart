import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/products/products_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProductsRepositoryImplementation implements ProductsRepository {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImplementation(this.productsRemoteDataSource);

  @override
  Future<Either<AppError, Product>> create(Product product) async {
    final productModel = product.toCreateProductJson();
    final productResponse = await productsRemoteDataSource.add(productModel);
    return productResponse.fold((l) => Left(l), (r) => Right(r.toDomain()));
  }

  @override
  Future<Either<AppError, void>> delete(int id) async {
    final response = await productsRemoteDataSource.delete(id);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, Product>> get(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<AppError, List<Product>>> getAll() async {
    final response = await productsRemoteDataSource.getAll();
    return response.fold((l) => Left(l), (r) => Right(r.map((e) => e.toDomain()).toList()));
  }

  @override
  Future<Either<AppError, Product>> update(Product product) async {
    final productModel = product.toUpdateProductJson();
    final response = await productsRemoteDataSource.update(productModel);
    return response.fold((l) => Left(l), (r) => Right(r.toDomain()));
  }

  @override
  Future<Either<AppError, void>> createProducts(List<Product> products) async {
    final productsModel = products.map((e) => e.toCreateProductJson()).toList();
    final response = await productsRemoteDataSource.addProducts(productsModel);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, void>> updateProducts(List<Product> products) async {
    final productsModel = products.map((e) => e.toUpdateProductJson()).toList();
    final response = await productsRemoteDataSource.updateProducts(productsModel);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }
}
