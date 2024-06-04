import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/orders_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmPurchaseOrderButton extends ConsumerStatefulWidget {
  final PurchaseOrder order;
  const ConfirmPurchaseOrderButton({super.key, required this.order});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfirmPurchaseOrderButtonState();
}

class _ConfirmPurchaseOrderButtonState extends ConsumerState<ConfirmPurchaseOrderButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
            isLoading ? colorScheme.inversePrimary.withOpacity(0.2) : colorScheme.primary),
      ),
      onPressed: () => _onConfirmPurchase(),
      child: Text(isLoading ? Texts.confirming : Texts.confirmPurchase),
    );
  }

  Future<void> _onConfirmPurchase() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {});
    await _confirmPurchase();
  }

  Future<void> _confirmPurchase() async {
    await ref.read(ordersControllerProvider.notifier).confirmOrder(widget.order);
  }
}
