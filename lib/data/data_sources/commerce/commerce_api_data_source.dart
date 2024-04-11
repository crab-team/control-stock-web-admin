import 'package:control_stock_web_admin/data/data_sources/commerce/commerce_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/commerce_model.dart';
import 'package:control_stock_web_admin/data/responses/commerce_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';

class CommerceApiDataSource implements CommerceRemoteDataSource {
  final APIClient apiClient;

  CommerceApiDataSource(this.apiClient);

  String path = '/commerces';

  @override
  Future<CommerceResponse> getById(String id) async {
    try {
      final res = await apiClient.sendGet('$path/$id');
      return CommerceResponse.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(CommerceModel commerce) async {
    try {
      return await apiClient.sendPut('$path/${commerce.id}', body: commerce.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
