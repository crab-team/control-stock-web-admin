import 'package:control_stock_web_admin/data/data_sources/commerce/commerce_remote_data_source.dart';
import 'package:control_stock_web_admin/data/responses/commerce_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';

class CommerceApiDataSource implements CommerceRemoteDataSource {
  final APIClient apiClient;

  CommerceApiDataSource(this.apiClient);

  String path = '/commerces';

  @override
  Future<void> updateDiscountCashPercentage(double value) async {
    try {
      final body = {'discountCashPercentage': value};
      return await apiClient.sendPut('$path/discount-cash-percentage', body: body);
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
