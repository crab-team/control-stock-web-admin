import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/repositories/purchases_repository.dart';
import 'package:dartz/dartz.dart';

class ModifyStatusPurchaseOrder {
  final PurchasesRepository _purchasesRepository;

  ModifyStatusPurchaseOrder(this._purchasesRepository);

  Future<Either<Failure, void>> execute(int customerId, int purchaseId, PurchaseStatus purchaseStatus) async {
    return await _purchasesRepository.modifyStatus(customerId, purchaseId, purchaseStatus);
  }
}
