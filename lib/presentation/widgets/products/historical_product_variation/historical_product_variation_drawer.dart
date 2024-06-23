import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/products/historical_product_variation/historical_product_variation_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
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

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(PhosphorIcons.check_circle, color: colorScheme.success, size: 54),
                const Gap.small(),
              ],
            ),
          );
        });
  }
}
