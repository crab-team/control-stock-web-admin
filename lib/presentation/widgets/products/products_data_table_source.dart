import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
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
  final Function(Product productUpdated) onChangeAnyValue;
  final Function(String selectedProduct) onSelect;

  ProductDataTableSource({
    List<ProductDataTableModel>? data,
    List<String>? selectedProductsCode,
    required this.onDelete,
    required this.onChangeAnyValue,
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
          onFieldSubmitted: (value) => onChangeAnyValue(product.copyWith(costPrice: double.tryParse(value) ?? 0.0)),
        )),
        DataCell(Text('\$ ${product.publicPrice?.toStringAsFixed(2)}')),
        DataCell(Text('\$ ${product.cashPurchasePrice?.toStringAsFixed(2)}')),
        DataCell(Text(product.category.name.toUpperCase())),
        DataCell(TextFormField(
          controller: stockController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) => onChangeAnyValue(product.copyWith(stock: int.tryParse(value) ?? 0)),
        )),
        DataCell(Icon(
          product.isAlreadyPrinted ? PhosphorIcons.check : PhosphorIcons.minus,
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
            // IconButton(
            //   icon: Icon(
            //     PhosphorIcons.chart_pie_slice,
            //     color: colorScheme.secondary,
            //   ),
            //   onPressed: () => onAnalytics(product),
            // ),
          ],
        )),
      ],
    );
  }
}
