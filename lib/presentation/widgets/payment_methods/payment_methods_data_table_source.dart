import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class PaymentMethodsDataTableSource extends DataTableSource {
  final List<PaymentMethod> _data;
  final Function(int id) onDelete;
  final Function(PaymentMethod paymentMethod) onEdit;

  PaymentMethodsDataTableSource({
    List<PaymentMethod>? data,
    required this.onDelete,
    required this.onEdit,
  }) : _data = data ?? <PaymentMethod>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final paymentMethod = _data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(paymentMethod.name)),
        DataCell(Text(paymentMethod.installments.toString())),
        DataCell(Text('${paymentMethod.surchargePercentage}%')),
        DataCell(Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => onEdit(paymentMethod),
              icon: const Icon(PhosphorIcons.pencil),
              label: const Text(Texts.record),
            ),
            const Gap.medium(),
            ButtonWithConfirmation(
              onConfirm: () => onDelete(paymentMethod.id!),
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
