import 'package:control_stock_web_admin/presentation/providers/commerce/commerce_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncrementPercentageCashPaymentInput extends ConsumerStatefulWidget {
  const IncrementPercentageCashPaymentInput({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IncrementPercentageCashPaymentInputState();
}

class _IncrementPercentageCashPaymentInputState extends ConsumerState<IncrementPercentageCashPaymentInput> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commerceController);
    return state.when(
      data: (value) => _buildInput(value),
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Text('Error'),
    );
  }

  _buildInput(double value) {
    return SizedBox(
      width: 100,
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Porcentaje de pago en efectivo',
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => _updateCashPaymentPercentage(double.parse(value)),
        controller: TextEditingController(text: value.toString()),
      ),
    );
  }

  _updateCashPaymentPercentage(double value) {
    ref.read(commerceController.notifier).updateCashPaymentPercentage(value);
  }
}
