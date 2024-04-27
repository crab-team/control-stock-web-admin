import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/payment_methods/payment_methods_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/payment_method_model.dart';
import 'package:control_stock_web_admin/data/responses/payment_method_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:fpdart/fpdart.dart';

class PaymentMethodsApiDataSource implements PaymentMethodsRemoteDataSource {
  final APIClient apiClient;

  PaymentMethodsApiDataSource(this.apiClient);
  String path = '/commerces/1/paymentMethods';

  @override
  Future<Either<AppError, PaymentMethodResponse>> create(PaymentMethodModel paymentMethod) async {
    final body = paymentMethod.toCreatePaymentMethod();
    final res = await apiClient.sendPost(path, body: body);
    return res.fold((l) => Left(l), (r) => Right(PaymentMethodResponse.fromJson(r)));
  }

  @override
  Future<Either<AppError, void>> delete(int id) async {
    final response = await apiClient.sendDelete('$path/$id');
    return response.fold((l) => Left(l), (r) => const Right(null));
  }

  @override
  Future<Either<AppError, List<PaymentMethodResponse>>> getAll() async {
    final res = await apiClient.sendGet(path);
    return res.fold(
        (l) => Left(l), (r) => Right(r.map<PaymentMethodResponse>((e) => PaymentMethodResponse.fromJson(e)).toList()));
  }

  @override
  Future<Either<AppError, void>> update(PaymentMethodModel paymentMethod) async {
    final body = paymentMethod.toUpdatePaymentMethod();
    final response = await apiClient.sendPut('$path/${paymentMethod.id}', body: body);
    return response.fold((l) => Left(l), (r) => const Right(null));
  }
}
