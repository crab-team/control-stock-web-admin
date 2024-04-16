import 'package:control_stock_web_admin/data/data_sources/purchases/purchases_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/purchase_order_model.dart';
import 'package:control_stock_web_admin/data/responses/purchase_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:control_stock_web_admin/utils/logger.dart';

class PurchasesApiDataSource implements PurchasesRemoteDataSource {
  final APIClient apiClient;

  PurchasesApiDataSource(this.apiClient);
  String path = '/commerces/1/purchases';

  @override
  Future<void> createPurchase(int customerId, PurchaseOrderModel purchaseOrderModel) async {
    try {
      await apiClient.sendPost('$path?customerId=$customerId', body: purchaseOrderModel.toCreateJson());
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<PurchaseResponse>> getAll() async {
    try {
      final res = await apiClient.sendGet(path);
      final purchasesResponse = res.map<PurchaseResponse>((e) => PurchaseResponse.fromJson(e)).toList();
      return purchasesResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> delete(int customerId, int purchaseId) {
    try {
      return apiClient.sendDelete('$path/$purchaseId?customerId=$customerId');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> updatePurchase(int customerId, int purchaseId, PurchaseOrderModel purchaseOrderModel) {
    // TODO: implement updatePurchase
    throw UnimplementedError();
  }

  @override
  Future<void> modifyStatus(int customerId, int purchaseId, String purchaseStatus) {
    try {
      return apiClient.sendPatch('$path/$purchaseId/status?customerId=$customerId', body: {'status': purchaseStatus});
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
