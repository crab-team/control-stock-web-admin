import 'package:control_stock_web_admin/data/models/client_model.dart';
import 'package:control_stock_web_admin/data/responses/client_response.dart';

abstract class ClientsRemoteDataSource {
  Future<List<ClientResponse>> getClients();
  Future<ClientResponse> addClient(ClientModel client);
  Future<ClientResponse> updateClient(ClientModel client);
  Future<void> deleteClient(int id);
}
