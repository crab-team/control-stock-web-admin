import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/domain/repositories/commerce_repository.dart';
import 'package:dartz/dartz.dart';

class GetCommerceById {
  final CommerceRepository _commerceRepository;

  GetCommerceById(this._commerceRepository);

  Future<Either<Failure, Commerce>> execute(String commerceId) {
    return _commerceRepository.getById(commerceId);
  }
}
