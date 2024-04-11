import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';

class PurchasesDataTableSource extends DataTableSource {
  final List<Purchase> _data;
  final Function(int customerId, int id) onDelete;

  PurchasesDataTableSource({
    List<Purchase>? data,
    required this.onDelete,
  }) : _data = data ?? <Purchase>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final purchase = _data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(purchase.fullName)),
        DataCell(Text(purchase.productCode!)),
        DataCell(Text(purchase.productName!)),
        DataCell(Text(CurrencyFormatter.format(purchase.unitPrice, arsSettings))),
        DataCell(Text(purchase.quantity.toString())),
        DataCell(Text(CurrencyFormatter.format(purchase.totalShopping, arsSettings))),
        DataCell(Text(purchase.paymentMethodName.toString())),
        DataCell(Text(CurrencyFormatter.format(purchase.debt, arsSettings))),
        DataCell(ButtonWithConfirmation(
          onConfirm: () => onDelete(purchase.customerId!, purchase.id!),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
