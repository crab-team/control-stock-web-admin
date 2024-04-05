import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/presentation/providers/commerce/commerce_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/commerce/increment_percentage_cash_payment_input.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceScreen extends ConsumerWidget {
  const CommerceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commerceController);

    return state.when(
      data: (value) => _buildBody(value),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildBody(Commerce? commerce) {
    if (commerce == null) {
      return const Center(
        child: Text('No hay datos'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Text('Nombre: ${commerce.name}'), const Gap.medium(), const DiscountCashPercentageInput()],
    );
  }
}
