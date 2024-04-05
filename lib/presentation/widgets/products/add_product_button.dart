import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
import 'package:control_stock_web_admin/presentation/screens/products/product_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProductButton extends ConsumerWidget {
  const AddProductButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      icon: const Icon(PhosphorIcons.plus),
      onPressed: () => _goToProductForm(context, ref),
      label: const Text('Agregar producto'),
    );
  }

  _goToProductForm(BuildContext context, WidgetRef ref) {
    ref.read(drawerController.notifier).state = const ProductDrawer();
  }
}
