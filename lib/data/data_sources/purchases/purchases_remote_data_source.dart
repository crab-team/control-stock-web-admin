import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/models/purchase_order_model.dart';
import 'package:control_stock_web_admin/data/models/purchase_products_model.dart';
import 'package:control_stock_web_admin/data/responses/purchase_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class PurchasesRemoteDataSource {
  Future<Either<AppError, List<PurchaseResponse>>> getAll();
  Future<Either<AppError, void>> createPurchase(int customerId, Map<String, dynamic> purchaseModel);
  Future<Either<AppError, void>> updatePurchase(int customerId, int purchaseId, PurchaseOrderModel purchaseOrderModel);
  Future<Either<AppError, void>> delete(int customerId, int purchaseId);
  Future<Either<AppError, void>> modifyStatus(int customerId, int purchaseId, String purchaseStatus);
  Future<Either<AppError, void>> modifyProductsInPurchase(
      int commerceId, int customerId, int purchaseId, List<PurchaseProductModel> products);
}
