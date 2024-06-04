import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/categories/categories_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/repositories/categories_repository.dart';
import 'package:fpdart/fpdart.dart';

class CategoriesRepositoryImplementation implements CategoriesRepository {
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  CategoriesRepositoryImplementation(this.categoriesRemoteDataSource);

  @override
  Future<Either<AppError, Category>> get(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AppError, Category>> create(String categoryName, double percentageProfit, double extraCosts) async {
    final response = await categoriesRemoteDataSource.addCategory(categoryName, percentageProfit, extraCosts);
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toDomain()),
    );
  }

  @override
  Future<Either<AppError, void>> delete(int id) async {
    final response = await categoriesRemoteDataSource.deleteCategory(id);
    return response.fold(
      (l) => Left(l),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<AppError, List<Category>>> getAll() async {
    final response = await categoriesRemoteDataSource.getCategories();
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.map((e) => e.toDomain()).toList()),
    );
  }

  @override
  Future<Either<AppError, Category>> update(Category category) async {
    final response = await categoriesRemoteDataSource.updateCategory(category);
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toDomain()),
    );
  }
}
