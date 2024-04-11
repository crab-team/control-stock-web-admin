import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/repositories/purchases_repository.dart';
import 'package:dartz/dartz.dart';

class GetPurchases {
  final PurchasesRepository _repository;

  GetPurchases(this._repository);

  Future<Either<Failure, List<Purchase>>> execute() {
    return _repository.getAll();
  }
}
