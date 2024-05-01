import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/number_inc_dec.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/search_bar_menu_widget.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductOrderManagerDataTableSource extends DataTableSource {
  final List<PurchaseProduct> _data;
  final Function(PurchaseProduct value) onProductSelected;
  final Function(PurchaseProduct value) onScanQRPressed;
  final Function(int id) onClear;

  ProductOrderManagerDataTableSource({
    List<PurchaseProduct>? data,
    required this.onProductSelected,
    required this.onScanQRPressed,
    required this.onClear,
  }) : _data = data ?? <PurchaseProduct>[];

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
        DataCell(_buildSelector(ValueKey('${productOrder.viewId}-code'), productOrder)),
        DataCell(_buildQuantitySelector(ValueKey('${productOrder.viewId}-quantity'), productOrder)),
        DataCell(
          Text(CurrencyFormatter.format((productOrder.unitPrice ?? 0) * (productOrder.quantity ?? 0), arsSettings)),
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
              onPressed: () => onClear(productOrder.viewId),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildSelector(ValueKey key, PurchaseProduct initialValue) {
    return Consumer(builder: (context, ref, _) {
      final values = ref.watch(productsControllerProvider.notifier).products;

      return SearchBarMenuWidget<Product>.withoutBorder(
        key: key,
        initialValue: initialValue.code,
        hintText: Texts.selectProduct,
        alreadySelectedProducts: const [],
        onSelected: (p0) {
          final selectedPurchaseProduct = PurchaseProduct(
            productId: p0.id,
            code: p0.code,
            name: p0.name,
            viewId: initialValue.viewId,
            quantity: 1,
            maxStock: p0.stock,
            unitPrice: p0.publicPrice ?? 0,
          );
          onProductSelected(selectedPurchaseProduct);
        },
        values: values,
      );
    });
  }

  Widget _buildQuantitySelector(ValueKey key, PurchaseProduct purchaseProduct) {
    return NumberIncDec.withoutBorder(
      key: UniqueKey(),
      value: purchaseProduct.quantity,
      maxValue: purchaseProduct.maxStock,
      onChanged: (value) {
        PurchaseProduct updated = purchaseProduct.copyWith(quantity: value);
        onProductSelected(updated);
      },
    );
  }

  @override
  int get selectedRowCount => 0;
}
