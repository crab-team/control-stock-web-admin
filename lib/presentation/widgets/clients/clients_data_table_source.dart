import 'package:control_stock_web_admin/domain/entities/client.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:flutter/material.dart';

class ClientsDataTableSource extends DataTableSource {
  final List<Client> _data;
  final Function(int id) onDelete;

  ClientsDataTableSource({
    List<Client>? data,
    required this.onDelete,
  }) : _data = data ?? <Client>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final client = _data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(client.name)),
        DataCell(Text(client.lastName)),
        DataCell(Text(client.email ?? '-')),
        DataCell(Text(client.phone ?? '-')),
        DataCell(Text(client.address ?? '-')),
        DataCell(ButtonWithConfirmation(
          onConfirm: () => onDelete(client.id!),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
