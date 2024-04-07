import 'package:control_stock_web_admin/presentation/providers/orders/order_products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderSummary extends ConsumerWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(orderProductsControllerProvider);

    int quantity = products.length;
    double total = products.map((e) => e.price).fold(0, (p0, p1) => p0 + p1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Texts.resume,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Gap.small(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Texts.total,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              CurrencyFormatter.format(total, arsSettings),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        const Gap.small(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Texts.quantity,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              quantity.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
