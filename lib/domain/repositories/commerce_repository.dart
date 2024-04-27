import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:fpdart/fpdart.dart';

abstract class CommerceRepository {
  Future<Either<AppError, Commerce>> getById(String id);
  Future<Either<AppError, void>> update(Commerce commerce);
}
