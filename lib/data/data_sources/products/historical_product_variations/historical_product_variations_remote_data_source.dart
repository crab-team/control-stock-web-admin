import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/models/historical_product_variations_model.dart';
import 'package:control_stock_web_admin/data/responses/historical_product_variations_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class HistoricalProductVariationsRemoteDataSource {
  Future<Either<AppError, List<HistoricalProductVariationsResponse>>> getAll(int productId);
  Future<Either<AppError, HistoricalProductVariationsResponse>> add(HistoricalProductVariationsModel product);
}
