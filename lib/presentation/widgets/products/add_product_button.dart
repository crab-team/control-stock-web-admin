import 'package:control_stock_web_admin/core/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProductButton extends ConsumerWidget {
  const AddProductButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      icon: const Icon(PhosphorIcons.plus),
      onPressed: () => _goToProductForm(context, ref),
      label: const Text('Agregar producto'),
    );
  }

  _goToProductForm(BuildContext context, WidgetRef ref) {
    ref.read(navigationServiceProvider).goToCreateProduct(context);
  }
}
