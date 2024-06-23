import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/historical_product_variations.dart';
import 'package:fpdart/fpdart.dart';

abstract class HistoricalProductVariationRepository {
  Future<Either<AppError, List<HistoricalProductVariations>>> getHistoricalProductVariations(int productId);
}
