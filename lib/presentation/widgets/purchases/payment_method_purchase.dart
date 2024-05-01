import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/presentation/providers/payment_methods/payment_methods_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/purchases/purchase_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentMethodPurchase extends ConsumerStatefulWidget {
  const PaymentMethodPurchase({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentMethodPurchaseState();
}

class _PaymentMethodPurchaseState extends ConsumerState<PaymentMethodPurchase> {
  @override
  Widget build(BuildContext context) {
    final paymentMethodState = ref.watch(paymentMethodsControllerProvider);
    final purchaseState = ref.watch(purchaseControllerProvider).asData?.value;

    if (purchaseState == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          Texts.paymentMethod,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Gap.small(),
        paymentMethodState.when(
          data: (values) {
            return SelectorWidget<PaymentMethod>(
              label: Texts.selectPaymentMethod,
              initialValue: purchaseState.paymentMethod?.name,
              items: values,
              onSelected: (value) => _setPaymentMethod(value),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text(error.toString())),
        ),
        const Gap.small(),
        TextFormField(
          initialValue: purchaseState.totalShopping?.toStringAsFixed(2),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: Texts.give),
          inputFormatters: [FilteringTextInputFormatter.allow(currencyInputFormatter)],
          onChanged: (value) => _setCustomerPayAmount(value == '' ? '0' : value),
          validator: (value) {
            if (value!.isEmpty) {
              return Texts.requiredField;
            }

            double doubleValue = double.parse(value.replaceAll(',', '.'));

            if (doubleValue > purchaseState.totalShopping!) {
              return Texts.valueSuperiorToTotal;
            }

            return null;
          },
        ),
      ],
    );
  }

  void _setPaymentMethod(PaymentMethod? value) {
    if (value != null) {
      ref.read(purchaseControllerProvider.notifier).setPaymentMethod(value);
    }
    setState(() {});
  }

  void _setCustomerPayAmount(String amount) {
    final amountParsed = double.parse(amount.replaceAll(',', '.'));
    ref.read(purchaseControllerProvider.notifier).setCustomerPayAmount(amountParsed);
  }
}
