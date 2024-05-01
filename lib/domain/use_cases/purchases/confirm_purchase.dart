import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/repositories/purchases_repository.dart';
import 'package:fpdart/fpdart.dart';

class ConfirmPurchaseOrder {
  final PurchasesRepository _shoppingRepository;

  ConfirmPurchaseOrder(this._shoppingRepository);

  Future<Either<AppError, void>> execute(Purchase purchase) async {
    return await _shoppingRepository.confirmPurchase(purchase);
  }
}
