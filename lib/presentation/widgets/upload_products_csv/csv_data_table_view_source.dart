import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CSVDataTableViewSource extends DataTableSource {
  final List<Product> _data;
  final Function(String code) onDelete;
  final Function(String code, String valueModified, String value) onChangeAnyValue;

  CSVDataTableViewSource({List<Product>? data, required this.onDelete, required this.onChangeAnyValue})
      : _data = data ?? <Product>[];

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
    nameController.text = product.name;
    priceController.text = product.price.toString();
    stockController.text = product.stock.toString();

    bool hasSomeAnomaly = product.name.isEmpty ||
        product.price == 0 ||
        product.stock == 0 ||
        RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$£ï¿½]').hasMatch(product.name) ||
        RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$£ï¿½]').hasMatch(product.code);

    return DataRow.byIndex(
      index: index,
      color: MaterialStateProperty.all(hasSomeAnomaly ? colorScheme.tertiary.withOpacity(0.05) : Colors.transparent),
      cells: [
        DataCell(Text(product.code)),
        DataCell(TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) {
            onChangeAnyValue(product.code, 'name', value);
          },
        )),
        DataCell(TextFormField(
          controller: priceController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            prefix: Text('\$ '),
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) => onChangeAnyValue(product.code, 'price', value),
        )),
        DataCell(Text(product.category.toUpperCase())),
        DataCell(TextFormField(
          controller: stockController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) => onChangeAnyValue(product.code, 'stock', value),
        )),
        DataCell(ButtonWithConfirmation(onConfirm: () {
          onDelete(product.code);
        })),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
