import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/orders/confirm_purchase_button.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';

class OrdersDataTableSource extends DataTableSource {
  final List<PurchaseOrder> _data;
  final Function(int id) onDelete;

  OrdersDataTableSource({
    List<PurchaseOrder>? data,
    required this.onDelete,
  }) : _data = data ?? <PurchaseOrder>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final order = _data[index];
    List<String> productsCodes = order.products.map((e) => e.code).toSet().toList();
    int quantity = order.products.fold(0, (p0, p1) => p0 + p1.quantity);
    double total = order.products.map((e) => e.unitPrice).fold(0, (p0, p1) => p0 + p1);

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(order.id!.toString())),
        DataCell(Text(order.customer!.fullName)),
        DataCell(Text(productsCodes.join(' - '))),
        DataCell(Text(quantity.toString())),
        DataCell(Text(CurrencyFormatter.format(total, arsSettings))),
        DataCell(Text(order.paymentMethod.name)),
        DataCell(Text(CurrencyFormatter.format(order.debt, arsSettings))),
        DataCell(Row(
          children: [
            ConfirmPurchaseOrderButton(order: order),
            const Gap.small(isHorizontal: true),
            ButtonWithConfirmation(
              onConfirm: () => onDelete(order.id!),
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
