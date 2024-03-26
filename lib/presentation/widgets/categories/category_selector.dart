import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
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
  List<Category> categories = [];
  Category? _selectedCategory;

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_selectedCategory == null && categories.isNotEmpty && widget.initialCategory != null) {
            _selectedCategory = categories.firstWhere((element) => element.name == widget.initialCategory);
            widget.onCategorySelected(_selectedCategory);
            setState(() {});
          }
        });

        return DropdownButtonFormField<Category>(
          decoration: InputDecoration(
            border: widget.asFilter ? const OutlineInputBorder(borderSide: BorderSide.none) : null,
            contentPadding: widget.asFilter ? EdgeInsets.zero : null,
          ),
          borderRadius: BorderRadius.circular(widget.asFilter ? 0 : kRadiusCornerInside),
          hint: Text(
            Texts.categories,
            style: widget.asFilter
                ? Theme.of(context).textTheme.bodyMedium!.copyWith(color: colorScheme.inversePrimary)
                : null,
          ),
          value: _selectedCategory,
          validator: (value) {
            if (value == null) {
              return Texts.requiredField;
            }
            return null;
          },
          icon: _selectedCategory == null
              ? null
              : Center(
                  child: IconButton(
                    icon: const Center(child: Icon(PhosphorIcons.x, size: 14)),
                    onPressed: () => _onClear(),
                  ),
                ),
          onChanged: (Category? value) => _onChange(value?.id),
          selectedItemBuilder: (context) {
            return categories.map<Widget>((Category category) {
              return Text(
                widget.asFilter ? Texts.categories : category.name.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: colorScheme.inversePrimary),
              );
            }).toList();
          },
          items: categories
              .map<DropdownMenuItem<Category>>(
                (Category category) => DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name.toUpperCase()),
                ),
              )
              .toList(),
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

  _onChange(int? categoryId) {
    _selectedCategory = categories.firstWhere((element) => element.id == categoryId);
    widget.onCategorySelected(_selectedCategory);
    setState(() {});
  }

  _onClear() {
    _selectedCategory = null;
    widget.onCategorySelected(null);
    setState(() {});
  }
}
