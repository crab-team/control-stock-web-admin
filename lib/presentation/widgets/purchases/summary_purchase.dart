import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order_product.dart';
import 'package:control_stock_web_admin/presentation/providers/purchases/purchase_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryPurchase extends ConsumerStatefulWidget {
  const SummaryPurchase({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SummaryPurchaseState();
}

class _SummaryPurchaseState extends ConsumerState<SummaryPurchase> {
  Customer? customer;
  PaymentMethod? paymentMethod;
  List<PurchaseOrderProduct> productsSelected = [];

  @override
  Widget build(BuildContext context) {
    final purchaseState = ref.watch(purchaseControllerProvider).asData?.value;
    final quantity = purchaseState?.purchaseProducts.fold<int>(
          0,
          (previousValue, element) => previousValue + (element.quantity ?? 0),
        ) ??
        0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(Texts.resume).bodyLarge,
        const Gap.small(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(Texts.quantity).bodyMedium,
            Text(quantity.toString()).bodyMedium,
          ],
        ),
        const Gap.small(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(Texts.subtotal).bodyMedium,
            Text(CurrencyFormatter.format(purchaseState?.subtotalShopping ?? 0, arsSettings)).bodyMedium,
          ],
        ),
        const Gap.small(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('${Texts.surcharge}/${Texts.discount}').bodyMedium,
            Text('${purchaseState?.paymentMethod?.surchargePercentage ?? 0}%').bodyMedium,
          ],
        ),
        const Gap.small(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(Texts.debt).bodyMedium,
            Text(CurrencyFormatter.format(purchaseState?.debt ?? '0', arsSettings)).bodyMedium,
          ],
        ),
        const Gap.small(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(Texts.total).headlineMedium,
            Text(CurrencyFormatter.format(purchaseState?.totalShopping ?? '0', arsSettings)).headlineMedium,
          ],
        ),
      ],
    );
  }
}
