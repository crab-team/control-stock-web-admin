import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/repositories/purchases_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePurchase {
  final PurchasesRepository _repository;

  DeletePurchase(this._repository);

  Future<Either<Failure, void>> execute(int customerId, int id) async {
    return _repository.delete(customerId, id);
  }
}
