import 'package:control_stock_web_admin/data/data_sources/payment_methods/payment_methods_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/payment_method_model.dart';
import 'package:control_stock_web_admin/data/responses/payment_method_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';

class PaymentMethodsApiDataSource implements PaymentMethodsRemoteDataSource {
  final APIClient apiClient;

  PaymentMethodsApiDataSource(this.apiClient);
  String path = 'commerces/3/paymentMethods';

  @override
  Future<PaymentMethodResponse> create(PaymentMethodModel paymentMethod) async {
    try {
      final body = paymentMethod.toCreatePaymentMethodJson();
      final res = await apiClient.sendPost(path, body: body);
      return PaymentMethodResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      return await apiClient.sendDelete('$path/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PaymentMethodResponse>> getAll() async {
    try {
      final res = await apiClient.sendGet(path);
      return (res as List).map((e) => PaymentMethodResponse.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(PaymentMethodModel paymentMethod) async {
    try {
      final body = paymentMethod.toUpdatePaymentMethodJson();
      await apiClient.sendPut('$path/${paymentMethod.id}', body: body);
    } catch (e) {
      rethrow;
    }
  }
}
