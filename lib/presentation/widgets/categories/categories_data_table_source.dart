import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class CategoriesDataTableSource extends DataTableSource {
  final List<Category> _data;
  final Function(Category category) onEdit;
  final Function(int id) onDelete;
  final Function(Category productUpdated) onChangeAnyValue;
  final Function(int id) onApplyAdjust;

  CategoriesDataTableSource({
    List<Category>? data,
    required this.onEdit,
    required this.onDelete,
    required this.onChangeAnyValue,
    required this.onApplyAdjust,
  }) : _data = data ?? <Category>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final category = _data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(category.name.toUpperCase())),
        DataCell(Text('${category.percentageProfit} %')),
        DataCell(Text(CurrencyFormatter.format(category.extraCosts, arsSettings))),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(PhosphorIcons.pencil_simple),
              onPressed: () => onEdit(category),
            ),
            ButtonWithConfirmation(
              onConfirm: () => onDelete(category.id!),
            ),
            ElevatedButton(onPressed: () => onApplyAdjust(category.id!), child: const Text(Texts.applyAdjust))
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
