import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:intl/intl.dart';

class PurchasesDataTableSource extends DataTableSource {
  final List<Purchase> _data;
  final Function(Purchase purchase) onEdit;
  final Function(int customerId, int id) onDelete;

  PurchasesDataTableSource({
    List<Purchase>? data,
    required this.onEdit,
    required this.onDelete,
  }) : _data = data ?? <Purchase>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length * 2) {
      return null;
    }

    final purchase = _data[index];
    final purchaseProducts = purchase.purchaseProducts;
    final purchaseProductsNames = purchaseProducts.map((e) => e.name).join(', ');

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(purchase.fullName)),
        DataCell(Text(purchaseProductsNames)),
        DataCell(Text(CurrencyFormatter.format(purchase.totalShopping!, arsSettings))),
        DataCell(Text(DateFormat('dd-MM-yyyy – kk:mm').format(purchase.createdAt!))),
        DataCell(Row(
          children: [
            IconButton(onPressed: () => onEdit(purchase), icon: const Icon(PhosphorIcons.pencil)),
            const Gap.small(isHorizontal: true),
            ButtonWithConfirmation(onConfirm: () => onDelete(purchase.customerId!, purchase.id!)),
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
