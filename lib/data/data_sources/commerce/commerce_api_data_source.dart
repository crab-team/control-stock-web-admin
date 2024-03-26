import 'package:control_stock_web_admin/data/data_sources/commerce/commerce_remote_data_source.dart';
import 'package:control_stock_web_admin/data/responses/commerce_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';

class CommerceApiDataSource implements CommerceRemoteDataSource {
  final APIClient apiClient;

  CommerceApiDataSource(this.apiClient);

  String path = '/commerce';

  @override
  Future<void> updateCashPaymenetPercentage(double cashPaymentPercentage) async {
    try {
      final body = {'cashPaymentPercentage': cashPaymentPercentage};
      return await apiClient.sendPut('$path/cash-payment-percentage', body: body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommerceResponse> getById(String id) {
    try {
      return apiClient.sendGet('$path/$id').then((response) => CommerceResponse.fromJson(response));
    } catch (e) {
      rethrow;
    }
  }
}
