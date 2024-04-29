import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/order_products_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/orders/search_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductOrderSelector extends ConsumerStatefulWidget {
  final Product? initialValue;
  final void Function(Product?) onSelect;

  const ProductOrderSelector({super.key, this.initialValue, required this.onSelect});

  @override
  ConsumerState<ProductOrderSelector> createState() => _ProductOrderSelectorState();
}

class _ProductOrderSelectorState extends ConsumerState<ProductOrderSelector> {
  @override
  Widget build(BuildContext context) {
    final productsSelected = ref.watch(orderProductsControllerProvider);
    final codes = productsSelected.map((e) => e.code).toList();

    return SearchProduct(
      alreadySelectedProducts: codes,
      onProductSelected: (product) => _selectProduct(product),
    );
  }

  void _selectProduct(Product product) {
    widget.onSelect(product);
  }
}
