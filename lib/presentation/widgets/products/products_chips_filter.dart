import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChipsFilterTabBar extends ConsumerStatefulWidget {
  const ChipsFilterTabBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChipsFilterTabBarState();
}

class _ChipsFilterTabBarState extends ConsumerState<ChipsFilterTabBar> {
  List<Category> categories = [];
  String selectedCategory = 'Todos';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(categoriesControllerProvider.future).then((value) {
        categories = value;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesControllerProvider);

    return state.when(
      data: (values) {
        return SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 8,
            spacing: 8,
            children: [
              _buildFilter('Todos'),
              ...categories.map((category) => _buildFilter(category.name)),
            ],
          ),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
    );
  }

  Widget _buildFilter(String name) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: selectedCategory == name ? colorScheme.primary : Colors.white,
        side: BorderSide(color: colorScheme.secondary),
      ),
      onPressed: () => _onPressFilter(name),
      child: Text(
        name.toUpperCase(),
        style: TextStyle(color: selectedCategory == name ? Colors.white : colorScheme.primary),
      ),
    );
  }

  _onPressFilter(String name) {
    setState(() {
      if (selectedCategory == name || name == 'Todos') {
        selectedCategory = 'Todos';
        ref.read(productsControllerProvider.notifier).getAll();
        return;
      }

      selectedCategory = name;
    });

    ref.read(productsControllerProvider.notifier).search(name);
  }
}
