import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/payment_methods/payment_methods_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/repositories/payment_methods_repository.dart';
import 'package:fpdart/fpdart.dart';

class PaymentMethodsRepositoryImplementation implements PaymentMethodsRepository {
  final PaymentMethodsRemoteDataSource _paymentMethodsDataSource;

  PaymentMethodsRepositoryImplementation(this._paymentMethodsDataSource);

  @override
  Future<Either<AppError, List<PaymentMethod>>> getAll() async {
    final response = await _paymentMethodsDataSource.getAll();
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.map((e) => e.toDomain()).toList()),
    );
  }

  @override
  Future<Either<AppError, PaymentMethod>> create(PaymentMethod newPaymentMethod) async {
    final model = newPaymentMethod.toModel();
    final response = await _paymentMethodsDataSource.create(model);
    return response.fold((l) => Left(l), (r) => Right(r.toDomain()));
  }

  @override
  Future<Either<AppError, void>> delete(int id) async {
    final response = await _paymentMethodsDataSource.delete(id);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, void>> update(PaymentMethod paymentMethod) async {
    final response = await _paymentMethodsDataSource.update(paymentMethod.toModel());
    return response.fold((l) => Left(l), (r) => const Right(null));
  }
}
