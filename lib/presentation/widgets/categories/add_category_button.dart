import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
import 'package:control_stock_web_admin/presentation/screens/categories/category_drawer.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCategoryButton extends ConsumerWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      icon: const Icon(PhosphorIcons.plus),
      onPressed: () => _goToCreateCategory(context, ref),
      label: const Text(Texts.createCategory),
    );
  }

  _goToCreateCategory(BuildContext context, WidgetRef ref) {
    ref.read(drawerControllerProvider.notifier).state = const CategoryDrawer();
  }
}
