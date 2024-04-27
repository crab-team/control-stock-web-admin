import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/models/payment_method_model.dart';
import 'package:control_stock_web_admin/data/responses/payment_method_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class PaymentMethodsRemoteDataSource {
  Future<Either<AppError, List<PaymentMethodResponse>>> getAll();
  Future<Either<AppError, void>> update(PaymentMethodModel paymentMethod);
  Future<Either<AppError, void>> delete(int id);
  Future<Either<AppError, PaymentMethodResponse>> create(PaymentMethodModel paymentMethod);
}
