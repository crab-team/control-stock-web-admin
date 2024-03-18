import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:dartz/dartz.dart';

class CategoriesRepositoryImplementation implements CategoriesRepository {
  final APIClient apiClient;

  CategoriesRepositoryImplementation({required this.apiClient});

  @override
  Future<Either<Failure, void>> create(Category category) {
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
  Future<Either<Failure, List<Category>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> update(Category category) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
