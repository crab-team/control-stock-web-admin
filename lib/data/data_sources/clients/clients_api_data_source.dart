import 'package:control_stock_web_admin/data/data_sources/clients/clients_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/client_model.dart';
import 'package:control_stock_web_admin/data/responses/client_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:control_stock_web_admin/utils/logger.dart';

class ClientsApiDataSource implements ClientsRemoteDataSource {
  final APIClient apiClient;

  ClientsApiDataSource(this.apiClient);
  String path = '/clients';

  @override
  Future<List<ClientResponse>> getClients() async {
    try {
      final response = await apiClient.sendGet(path);
      final List<ClientResponse> clientsResponse =
          (response as List).map((clientResponse) => ClientResponse.fromJson(clientResponse)).toList();

      return clientsResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<ClientResponse> addClient(ClientModel model) async {
    try {
      final body = model.toCreateJson();
      final response = await apiClient.sendPost(path, body: body);
      final clientResponse = ClientResponse.fromJson(response);
      return clientResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<ClientResponse> updateClient(ClientModel model) async {
    try {
      final body = model.toUpdateJson();
      final response = await apiClient.sendPut('$path/${model.id}', body: body);
      final clientResponse = ClientResponse.fromJson(response);
      return clientResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> deleteClient(int id) async {
    try {
      await apiClient.sendDelete('$path/$id');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
