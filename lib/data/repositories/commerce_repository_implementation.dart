import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/data_sources/commerce/commerce_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/domain/repositories/commerce_repository.dart';
import 'package:dartz/dartz.dart';

class CommerceRepositoryImplementation implements CommerceRepository {
  final CommerceRemoteDataSource commerceRemoteDataSource;

  CommerceRepositoryImplementation(this.commerceRemoteDataSource);

  @override
  Future<Either<Failure, void>> updateDiscountCashPercentage(String commerceId, double cashPaymentPercentage) async {
    try {
      await commerceRemoteDataSource.updateDiscountCashPercentage(commerceId, cashPaymentPercentage);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Commerce>> getById(String id) async {
    try {
      final response = await commerceRemoteDataSource.getById(id);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> update(Commerce commerce) async {
    try {
      var commerceModel = commerce.toUpdateCommerceModel();
      await commerceRemoteDataSource.update(commerceModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
