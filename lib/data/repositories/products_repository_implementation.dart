import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/data_sources/products_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImplementation implements ProductsRepository {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImplementation(this.productsRemoteDataSource);

  @override
  Future<Either<Failure, Product>> create(Product product) async {
    try {
      final productResponse = await productsRemoteDataSource.add(product);
      return Right(productResponse.toDomain());
    } catch (e) {
      return Left(Failure('Error al crear el producto'));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      await productsRemoteDataSource.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Error al eliminar el producto'));
    }
  }

  @override
  Future<Either<Failure, Product>> get(String id) async {
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
      final productResponse = await productsRemoteDataSource.update(product);
      return Right(productResponse.toDomain());
    } catch (e) {
      return Left(Failure('Error al actualizar el producto'));
    }
  }
}
