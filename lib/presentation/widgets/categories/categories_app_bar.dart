import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/add_category_button.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesAppBar extends ConsumerWidget {
  const CategoriesAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SearchBar(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const LinearBorder(),
            ),
            leading: const Icon(PhosphorIcons.magnifying_glass),
            hintText: Texts.searchCategory,
            onChanged: (value) => _search(ref, value),
          ),
        ),
        const Gap.medium(isHorizontal: true),
        const AddCategoryButton(),
      ],
    );
  }

  void _search(WidgetRef ref, String query) {
    ref.read(categoriesControllerProvider.notifier).search(query);
  }
}
