import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class ProductDataTableModel {
  final Product product;
  final bool selected;

  ProductDataTableModel({
    required this.product,
    this.selected = false,
  });

  ProductDataTableModel copyWith({
    Product? product,
    bool? selected,
  }) {
    return ProductDataTableModel(
      product: product ?? this.product,
      selected: selected ?? this.selected,
    );
  }
}

class ProductDataTableSource extends DataTableSource {
  final List<ProductDataTableModel> _data;
  final Function(int code) onDelete;
  final Function(Product product) onEdit;
  final Function(Product code) onAnalytics;
  final Function(String selectedProduct) onSelect;

  ProductDataTableSource({
    List<ProductDataTableModel>? data,
    List<String>? selectedProductsCode,
    required this.onDelete,
    required this.onEdit,
    required this.onAnalytics,
    required this.onSelect,
  }) : _data = data ?? <ProductDataTableModel>[];

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _data.where((element) => element.selected).toList().length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final product = _data[index].product;
    final productIsSelected = _data[index].selected;
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController stockController = TextEditingController();
    nameController.text = product.name.toUpperCase();
    priceController.text = product.costPrice.toString();
    stockController.text = product.stock.toString();

    return DataRow.byIndex(
      index: index,
      onSelectChanged: (_) => onSelect(product.code),
      selected: productIsSelected,
      cells: [
        DataCell(Text(product.code)),
        DataCell(Text(product.name.toUpperCase())),
        DataCell(Text(CurrencyFormatter.format(product.costPrice, arsSettings))),
        DataCell(Text(CurrencyFormatter.format(product.publicPrice!, arsSettings))),
        DataCell(Text(product.category.name.toUpperCase())),
        DataCell(Text(product.stock.toString())),
        DataCell(Icon(
          product.hasQrPrinted ? PhosphorIcons.check : PhosphorIcons.minus,
        )),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(PhosphorIcons.pencil_simple),
              onPressed: () => onEdit(product),
            ),
            ButtonWithConfirmation(
              onConfirm: () => onDelete(product.id!),
            ),
            IconButton(
              icon: Icon(
                PhosphorIcons.chart_pie_slice,
                color: colorScheme.secondary,
              ),
              onPressed: () => onAnalytics(product),
            ),
          ],
        )),
      ],
    );
  }
}
