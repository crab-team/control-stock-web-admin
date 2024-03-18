import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/repositories/products_repository.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImplementation implements ProductsRepository {
  final APIClient apiClient;

  ProductsRepositoryImplementation(this.apiClient);

  @override
  Future<Either<Failure, Product>> create(Product product) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getAll() async {
    try {
      final products = [
        Product(
          id: '1',
          name: 'MEDALLA PLATA FLOR',
          code: '81905',
          price: 11009,
          stock: 10,
          type: 'Oro y plata',
          imageUrl: 'https://via.placeholder.com/150',
        ),
        Product(
          id: '2',
          name: 'PRODUCTO 2',
          code: '81906',
          price: 12009,
          stock: 20,
          type: 'Tipo 2',
          imageUrl: 'https://via.placeholder.com/150',
        ),
        Product(
          id: '20',
          name: 'PRODUCTO 20',
          code: '81924',
          price: 13009,
          stock: 30,
          type: 'Tipo 20',
          imageUrl: 'https://via.placeholder.com/150',
        ),
        Product(
          id: '3',
          name: 'PRODUCTO 3',
          code: '81907',
          price: 13009,
          stock: 30,
          type: 'Tipo 3',
          imageUrl: 'https://via.placeholder.com/150',
        ),
        Product(
          id: '4',
          name: 'PRODUCTO 4',
          code: '81908',
          price: 14009,
          stock: 40,
          type: 'Tipo 4',
          imageUrl: 'https://via.placeholder.com/150',
        ),
        Product(
          id: '5',
          name: 'PRODUCTO 5',
          code: '81909',
          price: 15009,
          stock: 50,
          type: 'Tipo 5',
          imageUrl: 'https://via.placeholder.com/150',
        ),
      ];

      await Future.delayed(const Duration(seconds: 2));

      return Right(products);
    } catch (e) {
      return Left(Failure('Error al obtener los productos'));
    }
  }

  @override
  Future<Either<Failure, Product>> update(Product product) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
