import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/presentation/providers/commerce/accounting_commerce_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountingForm extends ConsumerStatefulWidget {
  final Commerce commerce;
  const AccountingForm({super.key, required this.commerce});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountingFormConsumerState();
}

class _AccountingFormConsumerState extends ConsumerState<AccountingForm> {
  final globalKey = GlobalKey<FormState>();
  TextEditingController discountCashPercentageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    discountCashPercentageController.text = widget.commerce.discountCashPercentage.toString();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(accountingCommerceController, (prev, state) {
      if (state is AsyncData) {
        ToastUtils.showToast(context, Texts.saved, 'Se ha guardado la información\nde contabilidad', ToastType.success);
      } else if (state is AsyncError) {
        ToastUtils.showToast(
            context, Texts.error, 'No se ha podido guardar la información\nde contabilidad', ToastType.error);
      }
    });

    return _buildInput();
  }

  _buildInput() {
    return SizedBox(
      child: Form(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: discountCashPercentageController,
              decoration: const InputDecoration(
                labelText: Texts.discountCashPercentage,
              ),
              keyboardType: TextInputType.number,
            ),
            const Gap.small(),
            _builButton(),
          ],
        ),
      ),
    );
  }

  _builButton() {
    return ElevatedButton(
      onPressed: () => _onSubmit(),
      child: const Text(Texts.save),
    );
  }

  _onSubmit() {
    if (globalKey.currentState!.validate()) {
      var value = double.parse(discountCashPercentageController.text);
      ref.read(accountingCommerceController.notifier).updateCashPaymentPercentage(value);
    }
  }
}
