import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:control_stock_web_admin/presentation/providers/purchases/purchases_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/number_inc_dec.dart';
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
  late Purchase currentPurchase;
  double newTotal = 0;
  double newReturn = 0;
  List<PurchaseProduct> returnedProducts = [];

  @override
  initState() {
    super.initState();
    currentPurchase = widget.purchase;
    newTotal = currentPurchase.totalShopping!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Texts.purchases, style: Theme.of(context).textTheme.headlineMedium),
        const Gap.small(),
        const Divider(),
        const Gap.small(),
        _buildInitialSummary(context),
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
                itemCount: currentPurchase.purchaseProducts.length,
                itemBuilder: (_, index) => _buildProduct(currentPurchase.purchaseProducts[index]),
              ),
            ),
          ],
        )),
        const Gap.medium(),
        const Divider(),
        const Gap.small(),
        _buildSummary(),
        const Gap.small(),
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
                onPressed: () => ref.read(navigationServiceProvider).goBack(),
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

  Column _buildInitialSummary(BuildContext context) {
    return Column(
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
                Text(DateFormat('dd/MM/yyyy – kk:mm').format(currentPurchase.createdAt!))
              ],
            ),
            const Gap.small(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(Texts.paymentMethod, style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                Text(currentPurchase.paymentMethodName.toString()),
              ],
            ),
            const Gap.small(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${Texts.surcharge}/${Texts.discount}', style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                Text('${currentPurchase.paymentMethodSurchargePercentage} %'),
              ],
            ),
            const Gap.small(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(Texts.total, style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                Text(CurrencyFormatter.format(currentPurchase.totalShopping, arsSettings)),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(Texts.summary, style: Theme.of(context).textTheme.bodyLarge),
        const Gap.small(),
        Container(
          constraints: const BoxConstraints(minHeight: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Cantidad de productos a devolver', style: Theme.of(context).textTheme.bodyMedium),
              const Gap.small(),
              ...returnedProducts.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text('${e.code!} - ${e.name!}', style: Theme.of(context).textTheme.bodyMedium),
                        const Spacer(),
                        Text(e.quantity.toString()),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const Gap.small(),
        const Divider(),
        const Gap.small(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Devolucion', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(CurrencyFormatter.format(newReturn, arsSettings),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const Gap.small(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Nuevo total', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(CurrencyFormatter.format(newTotal, arsSettings),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildProduct(PurchaseProduct product) {
    int maxQuantity = widget.purchase.purchaseProducts.firstWhere((element) => element.id == product.id).quantity;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '${product.code!} - ${product.name!}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Row(
          children: [
            NumberIncDec(
              label: Texts.quantity,
              maxValue: maxQuantity,
              initialValue: product.quantity,
              onChanged: (value) {
                updatePurchaseProduct(product, value);
                setState(() {});
              },
            ),
          ],
        ),
        const Gap.small(isHorizontal: true),
        SizedBox(
          width: 100,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(CurrencyFormatter.format(product.unitPrice * product.quantity, arsSettings)),
          ),
        ),
      ],
    );
  }

  void updatePurchaseProduct(PurchaseProduct product, int newQuantity) {
    returnedProducts.removeWhere((element) => element.id == product.id);

    if (newQuantity < product.quantity) {
      final returnedProduct = product.copyWith(quantity: product.quantity - newQuantity);
      returnedProducts.add(returnedProduct);
    }

    newReturn =
        returnedProducts.fold(0, (previousValue, element) => previousValue + element.unitPrice * element.quantity);
    newTotal = currentPurchase.totalShopping! - newReturn;
  }

  void _onSubmit() {
    ref
        .read(purchasesControllerProvider.notifier)
        .modifyProductsInPurchase(currentPurchase.customerId!, currentPurchase.id!, returnedProducts);
    ref.read(navigationServiceProvider).goBack();
  }
}
