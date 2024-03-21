import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/data_sources/categories_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

class CategoriesRepositoryImplementation implements CategoriesRepository {
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  CategoriesRepositoryImplementation(this.categoriesRemoteDataSource);

  @override
  Future<Either<Failure, Category>> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Category>> create(String categoryName) async {
    try {
      final categoriesResponse = await categoriesRemoteDataSource.addCategory(categoryName);
      final category = categoriesResponse.toDomain();
      return Right(category);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      await categoriesRemoteDataSource.deleteCategory(id);
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getAll() async {
    try {
      final categoriesResponse = await categoriesRemoteDataSource.getCategories();
      final categories = categoriesResponse.map((e) => e.toDomain()).toList();
      return Right(categories);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Category>> update(Category category) async {
    try {
      final categoriesResponse = await categoriesRemoteDataSource.updateCategory(category);
      return Right(categoriesResponse.toDomain());
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
