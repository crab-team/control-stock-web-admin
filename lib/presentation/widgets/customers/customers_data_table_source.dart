import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class CustomersDataTableSource extends DataTableSource {
  final List<Customer> _data;
  final Function(int id) onDelete;
  final Function(int customerId) onGoToRecords;

  CustomersDataTableSource({
    List<Customer>? data,
    required this.onDelete,
    required this.onGoToRecords,
  }) : _data = data ?? <Customer>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final customer = _data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(customer.name)),
        DataCell(Text(customer.lastName)),
        DataCell(Text(customer.email ?? '-')),
        DataCell(Text(customer.phone ?? '-')),
        DataCell(Text(customer.address ?? '-')),
        DataCell(Text(CurrencyFormatter.format(customer.positiveBalance, arsSettings))),
        DataCell(Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => onGoToRecords(customer.id!),
              icon: const Icon(PhosphorIcons.files),
              label: const Text(Texts.record),
            ),
            const Gap.medium(),
            ButtonWithConfirmation(
              onConfirm: () => onDelete(customer.id!),
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
