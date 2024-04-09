import 'package:control_stock_web_admin/data/models/customer_model.dart';
import 'package:control_stock_web_admin/data/responses/customer_record_response.dart';
import 'package:control_stock_web_admin/data/responses/customer_response.dart';
import 'package:control_stock_web_admin/domain/entities/customer_record.dart';

abstract class CustomersRemoteDataSource {
  Future<List<CustomerResponse>> get();
  Future<CustomerResponse> add(CustomerModel client);
  Future<CustomerResponse> update(CustomerModel client);
  Future<void> delete(int id);

  //Records
  Future<void> createRecord(int customerId, String record);
  Future<void> deleteRecord(int recordId);
  Future<List<CustomerRecordResponse>> getRecords(int customerId);
}
