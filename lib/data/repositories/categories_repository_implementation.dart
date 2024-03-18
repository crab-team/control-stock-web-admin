import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:dartz/dartz.dart';

class CategoriesRepositoryImplementation implements CategoriesRepository {
  final APIClient apiClient;

  CategoriesRepositoryImplementation({required this.apiClient});

  @override
  Future<Either<Failure, Category>> create(String categoryName) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Category>> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Category>>> getAll() async {
    try {
      final categories = [
        Category(id: '1', name: 'Category 1'),
        Category(id: '2', name: 'Category 2'),
        Category(id: '3', name: 'Category 3'),
      ];

      await Future.delayed(const Duration(seconds: 2));
      return Right(categories);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Category>> update(Category category) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
