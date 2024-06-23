import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/historical_product_variations.dart';
import 'package:control_stock_web_admin/domain/repositories/historical_product_variation_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetHistoricalProductVariationUseCase {
  final HistoricalProductVariationRepository _historicalProductVariationRepository;

  GetHistoricalProductVariationUseCase(this._historicalProductVariationRepository);

  Future<Either<AppError, List<HistoricalProductVariations>>> call(int productId) {
    return _historicalProductVariationRepository.getHistoricalProductVariations(productId);
  }
}
