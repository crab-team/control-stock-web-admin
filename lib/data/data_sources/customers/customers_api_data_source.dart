import 'package:control_stock_web_admin/data/data_sources/customers/customers_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/customer_model.dart';
import 'package:control_stock_web_admin/data/models/customer_record_model.dart';
import 'package:control_stock_web_admin/data/responses/customer_record_response.dart';
import 'package:control_stock_web_admin/data/responses/customer_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:control_stock_web_admin/utils/logger.dart';

class CustomersApiDataSource implements CustomersRemoteDataSource {
  final APIClient apiClient;

  CustomersApiDataSource(this.apiClient);
  String path = 'commerces/3/customers';

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

  //Records
  @override
  Future<CustomerRecordResponse> createRecord(int customerId, CustomerRecordModel recordModel) {
    // TODO: implement createRecord
    throw UnimplementedError();
  }

  @override
  Future<void> deleteRecord(int recordId) {
    // TODO: implement deleteRecord
    throw UnimplementedError();
  }

  @override
  Future<List<CustomerRecordResponse>> getRecords(int customerId) async {
    try {
      final response = await apiClient.sendGet('$path/$customerId/records');
      final records = response.map<CustomerRecordResponse>((e) => CustomerRecordResponse.fromJson(e)).toList();
      return records;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<CustomerRecordResponse>> createRecords(int customerId, List<CustomerRecordModel> recordsModel) async {
    try {
      final body = recordsModel.map((e) => e.toJson()).toList();
      final response = await apiClient.sendPost(
        '$path/$customerId/records/bulk',
      );
      final records = response.map<CustomerRecordResponse>((e) => CustomerRecordResponse.fromJson(e)).toList();
      return records;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
