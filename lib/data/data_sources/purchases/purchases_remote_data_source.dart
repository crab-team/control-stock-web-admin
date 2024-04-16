import 'package:control_stock_web_admin/data/models/purchase_order_model.dart';
import 'package:control_stock_web_admin/data/responses/purchase_response.dart';

abstract class PurchasesRemoteDataSource {
  Future<List<PurchaseResponse>> getAll();
  Future<void> createPurchase(int customerId, PurchaseOrderModel purchaseOrderModel);
  Future<void> updatePurchase(int customerId, int purchaseId, PurchaseOrderModel purchaseOrderModel);
  Future<void> delete(int customerId, int purchaseId);
  Future<void> modifyStatus(int customerId, int purchaseId, String purchaseStatus);
}
