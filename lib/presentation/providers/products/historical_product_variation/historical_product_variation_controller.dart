import 'package:control_stock_web_admin/domain/entities/historical_product_variations.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getHistoricalProductVariationProvider =
    FutureProvider.autoDispose.family<List<HistoricalProductVariations>, int>((ref, productId) async {
  final result = await ref.read(getHistoricalProductVariationUseCaseProvider)(productId);
  return result.fold((l) => throw l, (r) => r);
});
