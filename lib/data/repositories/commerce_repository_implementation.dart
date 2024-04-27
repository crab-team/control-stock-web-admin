import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/commerce/commerce_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/domain/repositories/commerce_repository.dart';
import 'package:fpdart/fpdart.dart';

class CommerceRepositoryImplementation implements CommerceRepository {
  final CommerceRemoteDataSource commerceRemoteDataSource;

  CommerceRepositoryImplementation(this.commerceRemoteDataSource);

  @override
  Future<Either<AppError, Commerce>> getById(String id) async {
    final response = await commerceRemoteDataSource.getById(id);
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toDomain()),
    );
  }

  @override
  Future<Either<AppError, void>> update(Commerce commerce) async {
    var commerceModel = commerce.toUpdateCommerceModel();
    final response = await commerceRemoteDataSource.update(commerceModel);
    return response.fold(
      (l) => Left(l),
      (r) => const Right(null),
    );
  }
}
