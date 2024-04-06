import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/domain/repositories/commerce_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCommerce {
  final CommerceRepository _commerceRepository;

  UpdateCommerce(this._commerceRepository);

  Future<Either<Failure, void>> execute(Commerce commerce) async {
    return await _commerceRepository.update(commerce);
  }
}
