import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:control_stock_web_admin/domain/repositories/purchases_repository.dart';
import 'package:dartz/dartz.dart';

class ModifyProductsInPurchaseUseCase {
  final PurchasesRepository _repository;

  ModifyProductsInPurchaseUseCase(this._repository);

  Future<Either<Failure, void>> execute(
      int commerceId, int customerId, int purchaseId, List<PurchaseProduct> products) {
    return _repository.modifyProductsInPurchase(commerceId, customerId, purchaseId, products);
  }
}
