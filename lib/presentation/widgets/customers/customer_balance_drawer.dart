import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/customers/toggle_button_action.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerBalanceDrawer extends ConsumerStatefulWidget {
  final Customer customer;
  const CustomerBalanceDrawer({super.key, required this.customer});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrawerState();
}

class _DrawerState extends ConsumerState<CustomerBalanceDrawer> {
  final formKey = GlobalKey<FormState>();
  TextEditingController balanceController = TextEditingController();
  double balance = 0;
  ActionOverBalance action = ActionOverBalance.commerceReturnMoney;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(Texts.balance, style: Theme.of(context).textTheme.headlineMedium),
        const Gap.small(),
        const Divider(),
        const Gap.small(),
        Expanded(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildCustomerResume(),
                const Gap.medium(),
                const Divider(),
                const Gap.small(),
                ToggleButtonAction(
                  onChange: (value) => setState(() {
                    action = value;
                  }),
                ),
                const Gap.small(),
                TextFormField(
                  controller: balanceController,
                  decoration: InputDecoration(
                    labelText: action == ActionOverBalance.commerceReturnMoney ? Texts.returnMoney : Texts.give,
                    prefixIcon: const Icon(PhosphorIcons.currency_dollar),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.allow(currencyInputFormatter)],
                  onChanged: (value) => setState(() {
                    var newValue = value == '' ? 0 : double.parse(value.replaceAll(',', '.'));
                    newValue = action == ActionOverBalance.commerceReturnMoney ? newValue * -1 : newValue;
                    balance = widget.customer.balance + newValue;
                  }),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Texts.requiredField;
                    }
                    return null;
                  },
                ),
                const Gap.small(),
                const Divider(),
                const Gap.medium(),
                _buildSummary(),
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
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerResume() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Texts.balance,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Gap.small(),
        Text(
          CurrencyFormatter.format(widget.customer.balance, arsSettings),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          Texts.summary,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Texts.total, style: Theme.of(context).textTheme.labelLarge),
            const Gap.small(),
            Text(CurrencyFormatter.format(balance, arsSettings), style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      final client = Customer(
        id: widget.customer.id,
        name: widget.customer.name,
        phone: widget.customer.phone,
        address: widget.customer.address,
        lastName: widget.customer.lastName,
        email: widget.customer.email,
        balance: balance,
      );

      ref.read(customersControllerProvider.notifier).updateCustomer(client);
      ref.read(navigationServiceProvider).goBack(context);
    }
  }
}
