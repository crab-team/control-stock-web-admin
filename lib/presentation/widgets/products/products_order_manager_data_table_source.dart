import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/number_inc_dec.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/search_bar_menu_widget.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductOrder {
  int id;
  Product? product;
  int quantity;

  ProductOrder({
    required this.id,
    required this.quantity,
    this.product,
  });

  copyWith({
    int? id,
    Product? product,
    int? quantity,
  }) {
    return ProductOrder(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
      'quantity': quantity,
    };
  }
}

class ProductOrderManagerDataTableSource extends DataTableSource {
  final List<ProductOrder> _data;
  final Function(ProductOrder value) onProductSelected;
  final Function(ProductOrder value) onScanQRPressed;
  final Function(int id) onClear;

  ProductOrderManagerDataTableSource({
    List<ProductOrder>? data,
    required this.onProductSelected,
    required this.onScanQRPressed,
    required this.onClear,
  }) : _data = data ?? <ProductOrder>[];

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final productOrder = _data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(_buildSelector(productOrder)),
        DataCell(_buildQuantitySelector(productOrder)),
        DataCell(
          Text(CurrencyFormatter.format((productOrder.product?.publicPrice ?? 0) * productOrder.quantity, arsSettings)),
        ),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(PhosphorIcons.camera),
              onPressed: () => onScanQRPressed(productOrder),
            ),
            const Gap.small(isHorizontal: true),
            IconButton(
              icon: const Icon(PhosphorIcons.trash),
              onPressed: () => onClear(productOrder.id),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildSelector(ProductOrder productOrder) {
    return Consumer(builder: (context, ref, _) {
      final values = ref.watch(productsControllerProvider.notifier).products;

      return SearchBarMenuWidget<Product>.withoutBorder(
        key: ValueKey(productOrder.id),
        initialValue: productOrder.product?.code,
        hintText: Texts.selectProduct,
        alreadySelectedProducts: const [],
        onSelected: (p0) {
          productOrder.product = p0;
          onProductSelected(productOrder);
        },
        values: values,
      );
    });
  }

  Widget _buildQuantitySelector(ProductOrder productOrder) {
    return NumberIncDec.withoutBorder(
      key: UniqueKey(),
      initialValue: productOrder.quantity,
      onChanged: (value) {
        productOrder.quantity = value;
        onProductSelected(productOrder);
      },
    );
  }

  @override
  int get selectedRowCount => 0;
}
