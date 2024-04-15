import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/number_input.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PurchasesDrawer extends ConsumerStatefulWidget {
  final Purchase purchase;
  const PurchasesDrawer({super.key, required this.purchase});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrawerState();
}

class _DrawerState extends ConsumerState<PurchasesDrawer> {
  final paidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Texts.purchases,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap.small(),
        const Divider(),
        const Gap.small(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(Texts.summary, style: Theme.of(context).textTheme.bodyLarge),
            const Gap.small(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(Texts.createdAt, style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    Text(DateFormat('dd/MM/yyyy – kk:mm').format(widget.purchase.createdAt!))
                  ],
                ),
                const Gap.small(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(Texts.paymentMethod, style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    Text(widget.purchase.paymentMethodName.toString()),
                  ],
                ),
                const Gap.small(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${Texts.surcharge}/${Texts.discount}', style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    Text('${widget.purchase.paymentMethodSurchargePercentage} %'),
                  ],
                ),
                const Gap.small(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(Texts.total, style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    Text(CurrencyFormatter.format(widget.purchase.totalShopping, arsSettings)),
                  ],
                ),
              ],
            )
          ],
        ),
        const Gap.medium(),
        const Divider(),
        const Gap.small(),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(Texts.products, style: Theme.of(context).textTheme.bodyLarge),
            const Gap.small(),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, index) => const Gap.small(),
                itemCount: widget.purchase.purchaseProducts.length,
                itemBuilder: (_, index) => _buildProduct(widget.purchase.purchaseProducts[index]),
              ),
            ),
          ],
        )),
        const Gap.medium(),
        const Divider(),
        const Gap.medium(),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary),
                icon: const Icon(Icons.cancel),
                onPressed: () => ref.read(navigationServiceProvider).goBack(context),
                label: const Text(Texts.cancel),
              ),
              const Gap.small(isHorizontal: true),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary),
                icon: const Icon(Icons.save),
                onPressed: () => _onSubmit(),
                label: const Text(Texts.save),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProduct(PurchaseProduct product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${product.code!} - ${product.name!}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        NumberInput(
          label: Texts.quantity,
          maxValue: product.quantity,
          initialValue: product.quantity,
          onChanged: (value) => print(value),
        ),
      ],
    );
  }

  void _onSubmit() {
    final amount = double.parse(paidController.text);
    if (amount == 0) return;

    ref.read(navigationServiceProvider).goBack(context);
  }
}
