import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/order_products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderSummary extends ConsumerWidget {
  final PaymentMethod? paymentMethod;
  const OrderSummary({super.key, this.paymentMethod});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(orderProductsControllerProvider);
    int quantity = products.fold(0, (p0, p1) => p0 + p1.quantity);
    double total = (products.map((e) => e.unitPrice * e.quantity).fold(0, (p0, p1) => p0 + p1));

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
              Texts.quantity,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              quantity.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        // const Gap.small(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       Texts.subtotal,
        //       style: Theme.of(context).textTheme.bodyMedium,
        //     ),
        //     Text(
        //       CurrencyFormatter.format(subtotal, arsSettings),
        //       style: Theme.of(context).textTheme.bodyMedium,
        //     ),
        //   ],
        // ),
        const Gap.small(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${Texts.surcharge}/${Texts.discount}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${paymentMethod?.surchargePercentage ?? 0}%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const Gap.medium(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Texts.total,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              CurrencyFormatter.format(total, arsSettings),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ],
    );
  }
}
