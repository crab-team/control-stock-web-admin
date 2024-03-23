import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class ProductDataTableSource extends DataTableSource {
  final List<Product> _data;
  final Function(String code) onDelete;
  final Function(Product product) onEdit;
  final Function(Product code) onAnalytics;
  final Function(Product productUpdated) onChangeAnyValue;

  ProductDataTableSource({
    List<Product>? data,
    required this.onDelete,
    required this.onChangeAnyValue,
    required this.onEdit,
    required this.onAnalytics,
  }) : _data = data ?? <Product>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final product = _data[index];
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController stockController = TextEditingController();
    nameController.text = product.name.toUpperCase();
    priceController.text = product.price.toString();
    stockController.text = product.stock.toString();

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(product.code)),
        DataCell(TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) => onChangeAnyValue(product.copyWith(name: value)),
        )),
        DataCell(TextFormField(
          controller: priceController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            prefix: Text('\$ '),
          ),
          onFieldSubmitted: (value) => onChangeAnyValue(product.copyWith(price: double.tryParse(value) ?? 0.0)),
        )),
        DataCell(Text(product.category.toUpperCase())),
        DataCell(TextFormField(
          controller: stockController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) => onChangeAnyValue(product.copyWith(stock: int.tryParse(value) ?? 0)),
        )),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(PhosphorIcons.pencil),
              onPressed: () => onEdit(product),
            ),
            ButtonWithConfirmation(
              onConfirm: () => onDelete(product.code),
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

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
