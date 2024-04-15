import 'package:control_stock_web_admin/data/models/customer_model.dart';
import 'package:control_stock_web_admin/data/responses/customer_response.dart';

abstract class CustomersRemoteDataSource {
  Future<List<CustomerResponse>> getAll();
  Future<CustomerResponse> add(CustomerModel client);
  Future<CustomerResponse> update(CustomerModel client);
  Future<void> delete(int id);
}
