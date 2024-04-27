import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/models/customer_model.dart';
import 'package:control_stock_web_admin/data/responses/customer_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class CustomersRemoteDataSource {
  Future<Either<AppError, List<CustomerResponse>>> getAll();
  Future<Either<AppError, CustomerResponse>> add(CustomerModel client);
  Future<Either<AppError, CustomerResponse>> update(CustomerModel client);
  Future<Either<AppError, void>> delete(int id);
}
