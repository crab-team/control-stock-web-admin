import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:dartz/dartz.dart';

abstract class CommerceRepository {
  Future<Either<Failure, Commerce>> getById(String id);
  Future<Either<Failure, void>> update(Commerce commerce);
}
