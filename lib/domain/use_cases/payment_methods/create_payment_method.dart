import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/repositories/payment_methods_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePaymentMethod {
  final PaymentMethodsRepository _repository;

  CreatePaymentMethod(this._repository);

  Future<Either<Failure, PaymentMethod>> execute(PaymentMethod paymentMethod) async {
    return await _repository.create(paymentMethod);
  }
}
