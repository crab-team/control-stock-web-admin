import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/models/commerce_model.dart';
import 'package:control_stock_web_admin/data/responses/commerce_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class CommerceRemoteDataSource {
  Future<Either<AppError, CommerceResponse>> getById(String id);
  Future<Either<AppError, void>> update(CommerceModel commerce);
}
