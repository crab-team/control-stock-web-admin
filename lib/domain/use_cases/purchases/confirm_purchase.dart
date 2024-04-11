import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/domain/repositories/purchases_repository.dart';
import 'package:dartz/dartz.dart';

class ConfirmPurchaseOrder {
  final PurchasesRepository _shoppingRepository;

  ConfirmPurchaseOrder(this._shoppingRepository);

  Future<Either<Failure, void>> execute(PurchaseOrder purchaseOrder) async {
    return await _shoppingRepository.purchaseOrder(purchaseOrder);
  }
}
