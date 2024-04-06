import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/repositories/commerce_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCashPaymentPercentage {
  final CommerceRepository _repository;

  UpdateCashPaymentPercentage(this._repository);

  Future<Either<Failure, void>> execute(String commerceId, double value) async {
    return await _repository.updateDiscountCashPercentage(commerceId, value);
  }
}
