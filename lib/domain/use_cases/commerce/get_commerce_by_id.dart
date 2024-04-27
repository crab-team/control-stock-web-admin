import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/domain/repositories/commerce_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCommerceById {
  final CommerceRepository _commerceRepository;

  GetCommerceById(this._commerceRepository);

  Future<Either<AppError, Commerce>> execute(String commerceId) {
    return _commerceRepository.getById(commerceId);
  }
}
