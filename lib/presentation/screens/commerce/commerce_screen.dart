import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/presentation/providers/commerce/commerce_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/commerce/accounting_form.dart';
import 'package:control_stock_web_admin/presentation/widgets/commerce/commerce_form.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceScreen extends ConsumerWidget {
  const CommerceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commerceControllerProvider);
    return state.when(
      data: (value) => _buildScreen(context, value!),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }

  _buildScreen(BuildContext context, Commerce commerce) {
    return Padding(
      padding: kPaddingAppSmall,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: kPaddingAppSmall,
                  child: Text(
                    'Configuración de comercio',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const Divider(),
                const Gap.medium(),
                const CommerceForm(),
              ],
            ),
          ),
          const Gap.medium(isHorizontal: true),
          const VerticalDivider(),
          const Gap.medium(isHorizontal: true),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: kPaddingAppSmall,
                  child: Text(
                    'Datos de contabilidad',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const Divider(),
                const Gap.medium(isHorizontal: false),
                AccountingForm(commerce: commerce),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
