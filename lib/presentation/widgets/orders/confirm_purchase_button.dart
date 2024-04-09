import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/orders_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmPurchaseOrderButton extends ConsumerStatefulWidget {
  final PurcharseOrder order;
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
        backgroundColor: MaterialStateProperty.all<Color>(
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
    try {
      final products = ref.read(productsControllerProvider.notifier).products;
      List<Product> orderProducts = widget.order.products.map((p) {
        final product = products.firstWhere((element) => element.id == p.id);
        final newProduct = product.copyWith(stock: product.stock - p.quantity);
        return newProduct as Product;
      }).toList();

      await ref.read(productsControllerProvider.notifier).updateProducts(orderProducts);
      // await ref.read(customerRecordsControllerProvider.notifier).createRecords();
      ref.read(ordersControllerProvider.notifier).removeOrder(widget.order);
      ToastUtils.showToast(
          context, Texts.orderPurchaseConfrimated, Texts.orderPurchaseConfrimatedMessage, ToastType.success);
      setState(() {});
    } catch (e) {
      return ToastUtils.showToast(context, Texts.errorOccurred, Texts.errorOccurredTryAgain, ToastType.error);
    }
  }
}
