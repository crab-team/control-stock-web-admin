import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/domain/repositories/commerce_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateCommerce {
  final CommerceRepository _commerceRepository;

  UpdateCommerce(this._commerceRepository);

  Future<Either<AppError, void>> execute(Commerce commerce) async {
    return await _commerceRepository.update(commerce);
  }
}
