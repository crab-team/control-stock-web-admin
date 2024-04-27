import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:fpdart/fpdart.dart';

abstract class PaymentMethodsRepository {
  Future<Either<AppError, List<PaymentMethod>>> getAll();
  Future<Either<AppError, void>> update(PaymentMethod paymentMethod);
  Future<Either<AppError, void>> delete(int id);
  Future<Either<AppError, PaymentMethod>> create(PaymentMethod paymentMethod);
}
