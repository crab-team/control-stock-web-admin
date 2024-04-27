import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/customers/customers_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/customer_model.dart';
import 'package:control_stock_web_admin/data/responses/customer_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:fpdart/fpdart.dart';

class CustomersApiDataSource implements CustomersRemoteDataSource {
  final APIClient apiClient;

  CustomersApiDataSource(this.apiClient);
  String path = '/commerces/1/customers';

  @override
  Future<Either<AppError, List<CustomerResponse>>> getAll() async {
    final response = await apiClient.sendGet(path);
    return response.fold((l) => Left(l), (r) {
      final customersResponse = r.map<CustomerResponse>((e) => CustomerResponse.fromJson(e)).toList();
      return Right(customersResponse);
    });
  }

  @override
  Future<Either<AppError, CustomerResponse>> add(CustomerModel model) async {
    final body = model.toCreateJson();
    final response = await apiClient.sendPost(path, body: body);
    return response.fold((l) => Left(l), (r) => Right(CustomerResponse.fromJson(r)));
  }

  @override
  Future<Either<AppError, CustomerResponse>> update(CustomerModel model) async {
    final body = model.toUpdateJson();
    final response = await apiClient.sendPut('$path/${model.id}', body: body);
    return response.fold((l) => Left(l), (r) => Right(CustomerResponse.fromJson(r)));
  }

  @override
  Future<Either<AppError, void>> delete(int id) async {
    final response = await apiClient.sendDelete('$path/$id');
    return response.fold((l) => Left(l), (r) => const Right(null));
  }
}
