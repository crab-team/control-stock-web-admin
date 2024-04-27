import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/commerce/commerce_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/commerce_model.dart';
import 'package:control_stock_web_admin/data/responses/commerce_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:fpdart/fpdart.dart';

class CommerceApiDataSource implements CommerceRemoteDataSource {
  final APIClient apiClient;

  CommerceApiDataSource(this.apiClient);

  String path = '/commerces';

  @override
  Future<Either<AppError, CommerceResponse>> getById(String id) async {
    final response = await apiClient.sendGet('$path/$id');
    return response.fold(
      (l) => Left(l),
      (r) => Right(CommerceResponse.fromJson(r)),
    );
  }

  @override
  Future<Either<AppError, void>> update(CommerceModel commerce) async {
    final response = await apiClient.sendPut('$path/${commerce.id}', body: commerce.toJson());
    return response.fold(
      (l) => Left(l),
      (r) => const Right(null),
    );
  }
}
