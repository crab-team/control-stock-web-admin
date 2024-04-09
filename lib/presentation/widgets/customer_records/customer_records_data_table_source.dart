import 'package:control_stock_web_admin/domain/entities/customer_record.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';

class CustomerRecordsDataTableSource extends DataTableSource {
  final List<CustomerRecord> _data;
  final Function(int id) onDelete;

  CustomerRecordsDataTableSource({
    List<CustomerRecord>? data,
    required this.onDelete,
  }) : _data = data ?? <CustomerRecord>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final record = _data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(record.productCode.toString())),
        DataCell(Text(record.productName)),
        DataCell(Text(CurrencyFormatter.format(record.unitPrice, arsSettings))),
        DataCell(Text(record.quantity.toString())),
        DataCell(Text(CurrencyFormatter.format(record.shoppingTotal, arsSettings))),
        DataCell(Text(record.paymentStatus.label)),
        DataCell(Text(record.paymentMethod.label)),
        DataCell(Text('${record.surchargePercentage}%')),
        DataCell(ButtonWithConfirmation(
          onConfirm: () => onDelete(record.id!),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
