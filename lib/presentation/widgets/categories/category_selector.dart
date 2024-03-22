import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorySelector extends ConsumerStatefulWidget {
  final String? initialCategory;
  final void Function(Category?) onCategorySelected;
  const CategorySelector({super.key, this.initialCategory, required this.onCategorySelected});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends ConsumerState<CategorySelector> {
  List<Category> categories = [];
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(categoriesFutureProvider.future).then((value) {
        categories = value;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedCategory == null) {
        _selectedCategory = categories.firstWhere((element) => element.name == widget.initialCategory);
        widget.onCategorySelected(_selectedCategory);
        setState(() {});
      }
    });

    return DropdownButtonFormField<Category>(
      borderRadius: BorderRadius.circular(kRadiusCornerInside),
      hint: const Text(Texts.categories),
      value: _selectedCategory,
      validator: (value) {
        if (value == null) {
          return Texts.requiredField;
        }
        return null;
      },
      onChanged: (Category? value) => _onChange(value?.id),
      items: categories
          .map<DropdownMenuItem<Category>>(
            (Category category) => DropdownMenuItem<Category>(
              value: category,
              child: Text(category.name.toUpperCase()),
            ),
          )
          .toList(),
    );
  }

  _onChange(String? categoryId) {
    _selectedCategory = categories.firstWhere((element) => element.id == categoryId);
    widget.onCategorySelected(_selectedCategory);
    setState(() {});
  }
}
