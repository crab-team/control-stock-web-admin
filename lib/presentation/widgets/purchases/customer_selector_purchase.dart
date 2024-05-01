import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/purchases/purchase_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/search_bar_menu_widget.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerSelectorPurchase extends ConsumerStatefulWidget {
  const CustomerSelectorPurchase({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomerSelectorPurchaseState();
}

class _CustomerSelectorPurchaseState extends ConsumerState<CustomerSelectorPurchase> {
  @override
  Widget build(BuildContext context) {
    final customersState = ref.watch(customersControllerProvider);
    final purchaseState = ref.watch(purchaseControllerProvider).asData?.value;

    if (purchaseState == null) {
      return const SizedBox();
    }

    String initialValue =
        purchaseState.customer != null ? '${purchaseState.customer!.name} ${purchaseState.customer!.lastName}' : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Texts.customer,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Gap.small(),
        customersState.when(
          data: (values) {
            return SearchBarMenuWidget<Customer>(
              values: values,
              initialValue: initialValue,
              hintText: Texts.selectCustomer,
              alreadySelectedProducts: const [],
              onSelected: (value) {
                _onSelectCustomer(value);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text(error.toString())),
        ),
        const Gap.small(),
        if (purchaseState.customer != null) ...[
          Row(
            children: [
              const Text('${Texts.balance}: ').bodySmall,
              Text(
                CurrencyFormatter.format(purchaseState.customer!.balance, arsSettings),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: (purchaseState.customer?.balance ?? 0) >= 0 ? Colors.green : Colors.red),
              ),
            ],
          )
        ],
      ],
    );
  }

  void _onSelectCustomer(Customer customer) {
    ref.read(purchaseControllerProvider.notifier).setCustomer(customer);
  }
}
