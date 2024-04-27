import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/repositories/payment_methods_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetPaymentMethods {
  final PaymentMethodsRepository _repository;

  GetPaymentMethods(this._repository);

  Future<Either<AppError, List<PaymentMethod>>> execute() async {
    return await _repository.getAll();
  }
}
