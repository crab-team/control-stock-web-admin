import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/products/historical_product_variations/historical_product_variations_remote_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/historical_product_variations.dart';
import 'package:control_stock_web_admin/domain/repositories/historical_product_variation_repository.dart';
import 'package:fpdart/fpdart.dart';

class HistoricalProductVariationsRepositoryImplementation implements HistoricalProductVariationRepository {
  final HistoricalProductVariationsRemoteDataSource remoteDataSource;

  HistoricalProductVariationsRepositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<AppError, List<HistoricalProductVariations>>> getHistoricalProductVariations(int productId) async {
    final response = await remoteDataSource.getAll(productId);
    return response.fold((l) => Left(l), (r) => Right(r.map((e) => e.toDomain()).toList()));
  }
}
