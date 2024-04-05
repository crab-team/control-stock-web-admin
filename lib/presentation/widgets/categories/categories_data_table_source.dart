import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:flutter/material.dart';

class CategoriesDataTableSource extends DataTableSource {
  final List<Category> _data;
  final Function(int id) onDelete;
  final Function(Category productUpdated) onChangeAnyValue;

  CategoriesDataTableSource({
    List<Category>? data,
    required this.onDelete,
    required this.onChangeAnyValue,
  }) : _data = data ?? <Category>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final category = _data[index];
    TextEditingController percentageController = TextEditingController();
    percentageController.text = category.percentageProfit.toString();

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(category.name.toUpperCase())),
        DataCell(TextFormField(
          controller: percentageController,
          decoration: inputDataTableDecoration.copyWith(
            suffixText: '%',
          ),
          onFieldSubmitted: (value) => onChangeAnyValue(
            category.copyWith(percentageProfit: double.tryParse(value) ?? 0.0),
          ),
        )),
        DataCell(ButtonWithConfirmation(
          onConfirm: () => onDelete(category.id),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
