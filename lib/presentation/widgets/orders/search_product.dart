import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchProduct extends ConsumerStatefulWidget {
  final String? intialValue;
  final List<String> alreadySelectedProducts;
  final Function(Product) onProductSelected;
  final bool withoutBorder;

  const SearchProduct({
    super.key,
    this.intialValue,
    required this.alreadySelectedProducts,
    required this.onProductSelected,
    this.withoutBorder = false,
  });

  const SearchProduct.withoutBorder({
    super.key,
    this.intialValue,
    required this.alreadySelectedProducts,
    required this.onProductSelected,
  }) : withoutBorder = true;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchProductState();
}

class _SearchProductState extends ConsumerState<SearchProduct> {
  List<Product> products = [];
  List<Product> productsFiltered = [];

  @override
  void initState() {
    super.initState();
    products = ref.read(productsControllerProvider.notifier).products.where((element) {
      bool notContains = widget.alreadySelectedProducts.where((selected) => selected == element.code).isEmpty;
      return notContains && element.stock > 0;
    }).toList();

    productsFiltered = products;
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      viewOnChanged: (value) {
        if (value.isEmpty) {
          productsFiltered = products;
        }
        productsFiltered = products.where((element) {
          final byCode = element.code.toLowerCase().contains(value.toLowerCase());
          final byName = element.name.toLowerCase().contains(value.toLowerCase());
          return byCode || byName;
        }).toList();
      },
      viewBackgroundColor: colorScheme.background,
      viewSurfaceTintColor: colorScheme.background,
      viewShape: widget.withoutBorder
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadiusCornerInside),
              side: BorderSide(color: colorScheme.primaryContainer),
            ),
      suggestionsBuilder: (context, controller) {
        return productsFiltered.map((product) {
          return ListTile(
            title: Text(product.code),
            subtitle: Text(product.name),
            onTap: () => _selectProduct(controller, product),
          );
        }).toList();
      },
      builder: (context, controller) {
        controller.text = widget.intialValue ?? '';

        return SearchBar(
          controller: controller,
          leading: const Icon(PhosphorIcons.magnifying_glass),
          hintText: Texts.searchProduct,
          side: widget.withoutBorder
              ? null
              : MaterialStateProperty.all<BorderSide>(BorderSide(color: colorScheme.primaryContainer)),
          shape: widget.withoutBorder
              ? null
              : MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadiusCornerInside)),
                ),
          onTap: () {
            controller.openView();
          },
        );
      },
    );
  }

  void _selectProduct(SearchController searchController, Product product) {
    productsFiltered = [];
    searchController.closeView(product.code);
    widget.onProductSelected(product);
  }
}
