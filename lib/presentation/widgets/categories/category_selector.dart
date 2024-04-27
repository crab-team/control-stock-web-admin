import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorySelector extends ConsumerStatefulWidget {
  final String? initialCategory;
  final void Function(Category?) onCategorySelected;
  final bool asFilter;

  const CategorySelector({super.key, this.initialCategory, required this.onCategorySelected, this.asFilter = false});
  const CategorySelector.asFilter(
      {super.key, this.initialCategory, required this.onCategorySelected, this.asFilter = true});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends ConsumerState<CategorySelector> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesControllerProvider);

    return state.when(
      data: (values) {
        return SelectorWidget<Category>(
          label: Texts.categories,
          items: values,
          asFilter: widget.asFilter,
          onSelected: (value) {
            widget.onCategorySelected(value);
            setState(() {});
          },
        );
      },
      loading: () {
        return const Text(Texts.loading).bodyMedium;
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
    );
  }
}
