import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:fpdart/fpdart.dart';

abstract class PurchasesRepository {
  Future<Either<AppError, List<Purchase>>> getAll();
  Future<Either<AppError, void>> purchaseOrder(PurchaseOrder purchaseOrder);
  Future<Either<AppError, void>> delete(int customerId, int purchaseId);
  Future<Either<AppError, List<Purchase>>> getByCustomerId(int customerId);
  Future<Either<AppError, void>> modifyStatus(int customerId, int purchaseId, PurchaseStatus purchaseStatus);
  Future<Either<AppError, void>> modifyProductsInPurchase(
      int commerceId, int customerId, int purchaseId, List<PurchaseProduct> products);
}
