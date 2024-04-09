import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/data_sources/payment_methods/payment_methods_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/repositories/payment_methods_repository.dart';
import 'package:dartz/dartz.dart';

class PaymentMethodsRepositoryImplementation implements PaymentMethodsRepository {
  final PaymentMethodsRemoteDataSource _paymentMethodsDataSource;

  PaymentMethodsRepositoryImplementation(this._paymentMethodsDataSource);

  @override
  Future<Either<Failure, List<PaymentMethod>>> getAll() async {
    try {
      final response = await _paymentMethodsDataSource.getAll();
      final paymentMethods = response.map((e) => e.toDomain()).toList();
      return Right(paymentMethods);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentMethod>> create(PaymentMethod newPaymentMethod) async {
    try {
      final model = newPaymentMethod.toModel();
      final response = await _paymentMethodsDataSource.create(model);
      return Right(response.toDomain());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      await _paymentMethodsDataSource.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(PaymentMethod paymentMethod) async {
    try {
      await _paymentMethodsDataSource.update(paymentMethod.toModel());
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
