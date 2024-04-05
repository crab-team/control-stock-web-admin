import 'package:control_stock_web_admin/presentation/providers/commerce/commerce_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscountCashPercentageInput extends ConsumerStatefulWidget {
  const DiscountCashPercentageInput({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiscountCashPercentageInputState();
}

class _DiscountCashPercentageInputState extends ConsumerState<DiscountCashPercentageInput> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commerceController);
    return state.when(
      data: (value) => _buildInput(value?.discountCashPercentage ?? 0),
      loading: () => const SizedBox(),
      error: (error, stackTrace) => const SizedBox(),
    );
  }

  _buildInput(double value) {
    return SizedBox(
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Porcentaje de descuento en efectivo',
        ),
        keyboardType: TextInputType.number,
        onSubmitted: (value) => _updateCashPaymentPercentage(double.parse(value)),
        controller: TextEditingController(text: value.toString()),
      ),
    );
  }

  _updateCashPaymentPercentage(double value) {
    ref.read(commerceController.notifier).updateCashPaymentPercentage(value);
  }
}
