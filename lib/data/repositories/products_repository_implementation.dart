import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/data_sources/products/products_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImplementation implements ProductsRepository {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImplementation(this.productsRemoteDataSource);

  @override
  Future<Either<Failure, Product>> create(Product product) async {
    try {
      final productModel = product.toCreateProductJson();
      final productResponse = await productsRemoteDataSource.add(productModel);
      return Right(productResponse.toDomain());
    } catch (e) {
      return Left(Failure('Error al crear el producto'));
    }
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      await productsRemoteDataSource.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Error al eliminar el producto'));
    }
  }

  @override
  Future<Either<Failure, Product>> get(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getAll() async {
    try {
      final productsResponse = await productsRemoteDataSource.getAll();
      final products = productsResponse.map((e) => e.toDomain()).toList();
      return Right(products);
    } catch (e) {
      return Left(Failure('Error al obtener los productos'));
    }
  }

  @override
  Future<Either<Failure, Product>> update(Product product) async {
    try {
      final productModel = product.toUpdateProductJson();
      final productResponse = await productsRemoteDataSource.update(productModel);
      return Right(productResponse.toDomain());
    } catch (e) {
      return Left(Failure('Error al actualizar el producto'));
    }
  }

  @override
  Future<Either<Failure, void>> createProducts(List<Product> products) async {
    try {
      final productsModel = products.map((e) => e.toCreateProductJson()).toList();
      await productsRemoteDataSource.addProducts(productsModel);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Error al actualizar el producto'));
    }
  }
}
