import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:dartz/dartz.dart';

abstract class PurchasesRepository {
  Future<Either<Failure, List<Purchase>>> getAll();
  Future<Either<Failure, void>> purchaseOrder(PurchaseOrder purchaseOrder);
  Future<Either<Failure, void>> delete(int customerId, int purchaseId);
  Future<Either<Failure, List<Purchase>>> getByCustomerId(int customerId);
  Future<Either<Failure, void>> modifyStatus(int customerId, int purchaseId, PurchaseStatus purchaseStatus);
  Future<Either<Failure, void>> modifyProductsInPurchase(
      int commerceId, int customerId, int purchaseId, List<PurchaseProduct> products);
}
