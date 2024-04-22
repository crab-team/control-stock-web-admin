import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/purchases/purchases_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/toasts/toasts_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ordersControllerProvider = NotifierProvider<OrdersController, List<PurchaseOrder>>(OrdersController.new);

class OrdersController extends Notifier<List<PurchaseOrder>> {
  @override
  build() {
    return [];
  }

  addOrder(PurchaseOrder order) async {
    order = order.copyWith(id: state.length + 1);
    _showToast(ToastControllerModel(Texts.orders, '${Texts.orderAdded} ${order.id}', ToastType.success));
    state = [...state, order];
  }

  removeOrder(int orderId) async {
    state = state.where((element) => element.id != orderId).toList();
  }

  Future<void> confirmOrder(PurchaseOrder order) async {
    _showToast(ToastControllerModel(Texts.orders, '${Texts.confirmingOrder} ${order.id}', ToastType.info));
    final either = await ref.read(confirmPurchaseUseCaseProvider).execute(order);
    either.fold(
      (l) {
        _showToast(ToastControllerModel(Texts.orders, '${Texts.errorConfirmingOrder} ${order.id}', ToastType.error));
        throw Exception('Error');
      },
      (r) async {
        _showToast(
            ToastControllerModel(Texts.orders, '${Texts.orderPurchaseConfrimated} ${order.id}', ToastType.success));
        removeOrder(order.id!);
      },
    );

    await ref.read(productsControllerProvider.notifier).getAll();
    await ref.read(purchasesControllerProvider.notifier).getAll();
    await ref.read(customersControllerProvider.notifier).getAll();
  }

  search(String query) {
    final currentOrders = state;

    if (query.isEmpty || query == '') {
      state = currentOrders;
      return;
    }

    state = currentOrders.where((element) {
      final byCustomerName = element.customer!.name.toLowerCase().contains(query.toLowerCase());
      final byCustomerLastName = element.customer!.lastName.toLowerCase().contains(query.toLowerCase());
      final byProductCode =
          element.products.map((e) => e.code).toSet().toList().join('').toLowerCase().contains(query.toLowerCase());
      return byCustomerName || byCustomerLastName || byProductCode;
    }).toList();
  }

  _showToast(ToastControllerModel toastController) {
    ref.read(toastsControllerProvider.notifier).showToast(toastController);
  }
}
