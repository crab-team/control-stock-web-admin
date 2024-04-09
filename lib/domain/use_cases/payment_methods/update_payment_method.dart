import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/repositories/payment_methods_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePaymentMethod {
  final PaymentMethodsRepository _repository;

  UpdatePaymentMethod(this._repository);

  Future<Either<Failure, void>> execute(PaymentMethod paymentMethod) {
    return _repository.update(paymentMethod);
  }
}
