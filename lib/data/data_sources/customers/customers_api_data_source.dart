import 'package:control_stock_web_admin/data/data_sources/customers/customers_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/customer_model.dart';
import 'package:control_stock_web_admin/data/responses/customer_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:control_stock_web_admin/utils/logger.dart';

class CustomersApiDataSource implements CustomersRemoteDataSource {
  final APIClient apiClient;

  CustomersApiDataSource(this.apiClient);
  String path = '/customers';

  @override
  Future<List<CustomerResponse>> get() async {
    try {
      final response = await apiClient.sendGet(path);
      final List<CustomerResponse> customersResponse =
          (response as List).map((customerResponse) => CustomerResponse.fromJson(customerResponse)).toList();

      return customersResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<CustomerResponse> add(CustomerModel model) async {
    try {
      final body = model.toCreateJson();
      final response = await apiClient.sendPost(path, body: body);
      final customerResponse = CustomerResponse.fromJson(response);
      return customerResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<CustomerResponse> update(CustomerModel model) async {
    try {
      final body = model.toUpdateJson();
      final response = await apiClient.sendPut('$path/${model.id}', body: body);
      final customerResponse = CustomerResponse.fromJson(response);
      return customerResponse;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await apiClient.sendDelete('$path/$id');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
