import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/presentation/providers/payment_methods/payment_methods_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentMethodsDrawer extends ConsumerStatefulWidget {
  final PaymentMethod? paymentMethod;
  const PaymentMethodsDrawer({super.key, this.paymentMethod});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentMethodsDrawerState();
}

class _PaymentMethodsDrawerState extends ConsumerState<PaymentMethodsDrawer> {
  final formKey = GlobalKey<FormState>();
  TextEditingController methodController = TextEditingController();
  TextEditingController installmentsController = TextEditingController();
  TextEditingController surchargePercentageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.paymentMethod != null) {
      methodController.text = widget.paymentMethod?.name ?? '';
      installmentsController.text = widget.paymentMethod?.installments.toString() ?? '';
      surchargePercentageController.text = widget.paymentMethod?.surchargePercentage.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.paymentMethod != null ? Texts.editCustomer : Texts.addCustomer,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Gap.medium(),
        const Divider(),
        const Gap.medium(),
        Expanded(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: methodController,
                      decoration: const InputDecoration(labelText: Texts.name),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Texts.requiredField;
                        }
                        return null;
                      },
                    ),
                    const Gap.small(),
                    TextFormField(
                      controller: installmentsController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(labelText: Texts.installments),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Texts.requiredField;
                        }
                        return null;
                      },
                    ),
                    const Gap.small(),
                    TextFormField(
                      controller: surchargePercentageController,
                      decoration: const InputDecoration(labelText: Texts.surcharge),
                    ),
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
                            label: Text(widget.paymentMethod != null ? Texts.edit : Texts.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      final newPaymentMethod = PaymentMethod(
        id: widget.paymentMethod?.id,
        name: methodController.text,
        installments: int.parse(installmentsController.text),
        surchargePercentage: double.parse(surchargePercentageController.text),
      );

      if (widget.paymentMethod != null) {
        ref.read(paymentMethodsControllerProvider.notifier).updatePayment(newPaymentMethod);
      } else {
        ref.read(paymentMethodsControllerProvider.notifier).create(newPaymentMethod);
      }
      ref.read(navigationServiceProvider).goBack(context);
    }
  }
}
