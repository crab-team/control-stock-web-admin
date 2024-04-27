import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/repositories/purchases_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetPurchases {
  final PurchasesRepository _repository;

  GetPurchases(this._repository);

  Future<Either<AppError, List<Purchase>>> execute() {
    return _repository.getAll();
  }
}
