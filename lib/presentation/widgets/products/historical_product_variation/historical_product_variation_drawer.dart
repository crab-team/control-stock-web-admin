import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/historical_product_variations.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/products/historical_product_variation/historical_product_variation_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/utils/date_formatter.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/historical_product_variation/historical_product_variation_line_chart.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoricalProductVariationDrawer extends ConsumerStatefulWidget {
  final Product product;
  const HistoricalProductVariationDrawer({super.key, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HistoricalProductVariationDrawerState();
}

class HistoricalProductVariationDrawerState extends ConsumerState<HistoricalProductVariationDrawer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ref.read(getHistoricalProductVariationProvider(widget.product.id!).future),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, color: colorScheme.error),
                  const Gap.small(),
                  const Text(Texts.errorOccurred),
                ],
              ),
            );
          }

          Future.delayed(const Duration(seconds: 2), () {
            ref.read(productDrawerStateControllerProvider.notifier).state = ProductDrawerState.initial;
            return;
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Texts.analytics,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap.small(),
              _buildChart(snapshot.data as List<HistoricalProductVariations>)
            ],
          );
        });
  }

  Widget _buildChart(List<HistoricalProductVariations> historicalProductVariations) {
    List<ChartData> historicalPriceProductVariationsData = historicalProductVariations
        .map((e) => ChartData(
              DateFormatter.format(e.createdAt),
              e.price,
            ))
        .toList();

    List<ChartData> historicalStockProductVariationsData = historicalProductVariations
        .map((e) => ChartData(
              DateFormatter.format(e.createdAt),
              e.stock.toDouble(),
            ))
        .toList();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 6),
        child: Column(
          children: [
            Expanded(
              child: HistoricalProductVariationsLineChart(
                  title: Texts.priceVariations, values: historicalPriceProductVariationsData),
            ),
            const Gap.small(),
            Expanded(
              child: HistoricalProductVariationsLineChart(
                title: Texts.stockVariations,
                values: historicalStockProductVariationsData,
                color: colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
