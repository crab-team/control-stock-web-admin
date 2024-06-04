import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/purchases/purchases_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/purchase_order_model.dart';
import 'package:control_stock_web_admin/data/models/purchase_products_model.dart';
import 'package:control_stock_web_admin/data/responses/purchase_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:fpdart/fpdart.dart';

class PurchasesApiDataSource implements PurchasesRemoteDataSource {
  final APIClient apiClient;

  PurchasesApiDataSource(this.apiClient);
  String path = '/commerces/1/purchases';

  @override
  Future<Either<AppError, void>> createPurchase(int customerId, Map<String, dynamic> purchaseModel) async {
    final response = await apiClient.sendPost('$path?customerId=$customerId', body: purchaseModel);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, List<PurchaseResponse>>> getAll() async {
    final res = await apiClient.sendGet(path);
    return res.fold((l) => Left(l), (r) {
      final purchasesResponse = r.map<PurchaseResponse>((e) => PurchaseResponse.fromJson(e)).toList();
      return Right(purchasesResponse);
    });
  }

  @override
  Future<Either<AppError, void>> delete(int customerId, int purchaseId) async {
    final response = await apiClient.sendDelete('$path/$purchaseId?customerId=$customerId');
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, void>> updatePurchase(int customerId, int purchaseId, PurchaseOrderModel purchaseOrderModel) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AppError, void>> modifyStatus(int customerId, int purchaseId, String purchaseStatus) async {
    final response =
        await apiClient.sendPatch('$path/$purchaseId/status?customerId=$customerId', body: {'status': purchaseStatus});
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, void>> modifyProductsInPurchase(
      int commerceId, int customerId, int purchaseId, List<PurchaseProductModel> products) async {
    final body = products.map((e) => e.toUpdateJson()).toList();
    final response =
        await apiClient.sendPatch('$path/$purchaseId/returnProducts?customerId=$customerId', body: {'products': body});
    return response.fold((l) => Left(l), (r) => const Right(null));
  }
}
