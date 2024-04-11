import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:control_stock_web_admin/domain/repositories/shopping_repository.dart';
import 'package:dartz/dartz.dart';

class ConfirmPurchase {
  final PurchasesRepository _shoppingRepository;

  ConfirmPurchase(this._shoppingRepository);

  Future<Either<Failure, void>> execute(int customerId, PurchaseProducts purchaseProducts) async {
    return await _shoppingRepository.purchaseProducts(customerId, purchaseProducts);
  }
}
