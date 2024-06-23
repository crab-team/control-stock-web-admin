import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/products/historical_product_variations/historical_product_variations_remote_data_source.dart';
import 'package:control_stock_web_admin/data/models/historical_product_variations_model.dart';
import 'package:control_stock_web_admin/data/responses/historical_product_variations_response.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:fpdart/fpdart.dart';

class HistoricalProductVariationsApiDataSource implements HistoricalProductVariationsRemoteDataSource {
  final APIClient apiClient;

  HistoricalProductVariationsApiDataSource(this.apiClient);

  String path = '/commerces/1/historicalProductVariations';

  @override
  Future<Either<AppError, HistoricalProductVariationsResponse>> add(HistoricalProductVariationsModel model) async {
    final body = model.toCreateJson();
    final response = await apiClient.sendPost(path, body: body);
    return response.fold(
      (l) => Left(l),
      (r) => Right(HistoricalProductVariationsResponse.fromJson(r)),
    );
  }

  @override
  Future<Either<AppError, List<HistoricalProductVariationsResponse>>> getAll(int productId) async {
    final response = await apiClient.sendGet('$path/$productId');
    return response.fold((l) => Left(l), (r) {
      final products =
          r.map<HistoricalProductVariationsResponse>((e) => HistoricalProductVariationsResponse.fromJson(e)).toList();
      return Right(products);
    });
  }
}
