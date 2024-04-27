import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/repositories/payment_methods_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdatePaymentMethod {
  final PaymentMethodsRepository _repository;

  UpdatePaymentMethod(this._repository);

  Future<Either<AppError, void>> execute(PaymentMethod paymentMethod) {
    return _repository.update(paymentMethod);
  }
}
