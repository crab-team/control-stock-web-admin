import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentMethodsRepository {
  Future<Either<Failure, List<PaymentMethod>>> getAll();
  Future<Either<Failure, void>> update(PaymentMethod paymentMethod);
  Future<Either<Failure, void>> delete(int id);
  Future<Either<Failure, PaymentMethod>> create(PaymentMethod paymentMethod);
}
