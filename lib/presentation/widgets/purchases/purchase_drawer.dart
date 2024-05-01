import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/presentation/providers/purchases/purchase_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/purchases/customer_selector_purchase.dart';
import 'package:control_stock_web_admin/presentation/widgets/purchases/payment_method_purchase.dart';
import 'package:control_stock_web_admin/presentation/widgets/purchases/summary_purchase.dart';
import 'package:control_stock_web_admin/presentation/widgets/purchases/products_order_manager_data_table.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchaseDrawer extends ConsumerStatefulWidget {
  final PurchaseOrder? order;
  const PurchaseDrawer({super.key, this.order});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PurchaseDrawerStateConsumer();
}

class _PurchaseDrawerStateConsumer extends ConsumerState<PurchaseDrawer> {
  @override
  void initState() {
    super.initState();
    if (widget.order != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.order != null ? Texts.editPurchase : Texts.createPurchase,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap.small(),
          const Divider(),
          const Gap.small(),
          const Expanded(
            child: Row(
              children: [
                Expanded(flex: 2, child: ProductsOrderManagerDataTable()),
                Gap.small(isHorizontal: true),
                VerticalDivider(),
                Gap.small(isHorizontal: true),
                Expanded(
                    child: Column(
                  children: [
                    Expanded(child: CustomerSelectorPurchase()),
                    Gap.small(),
                    Divider(),
                    Gap.small(),
                    Expanded(
                      child: PaymentMethodPurchase(),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Column(
            children: [
              const Gap.small(),
              const Divider(),
              const Gap.small(),
              const SummaryPurchase(),
              const Gap.small(),
              const Divider(),
              const Gap.small(),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary),
                      icon: const Icon(PhosphorIcons.x_circle),
                      onPressed: () => ref.read(navigationServiceProvider).goBack(),
                      label: const Text(Texts.cancel),
                    ),
                    const Gap.small(isHorizontal: true),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary),
                        icon: const Icon(PhosphorIcons.floppy_disk),
                        onPressed: () => _onSubmit(),
                        label: Text(widget.order != null ? Texts.edit : Texts.accept),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    ref.read(purchaseControllerProvider.notifier).confirmPurchase();
    ref.read(navigationServiceProvider).goBack();
  }
}
