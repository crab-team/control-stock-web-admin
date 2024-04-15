import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/purchases/purchases_controller.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ordersControllerProvider = NotifierProvider<OrdersController, List<PurchaseOrder>>(OrdersController.new);

class OrdersController extends Notifier<List<PurchaseOrder>> {
  @override
  build() {
    return [];
  }

  addOrder(PurchaseOrder order) async {
    order = order.copyWith(id: state.length + 1);
    state = [...state, order];
  }

  removeOrder(int orderId) async {
    state = state.where((element) => element.id != orderId).toList();
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

  Future<void> confirmOrder(PurchaseOrder order) async {
    final either = await ref.read(confirmPurchaseUseCaseProvider).execute(order);
    either.fold(
      (l) => throw Exception('Error'),
      (r) async {
        removeOrder(order.id!);
      },
    );

    await ref.read(productsControllerProvider.notifier).getAll();
    await ref.read(purchasesControllerProvider.notifier).getAll();
    await ref.read(customersControllerProvider.notifier).getAll();
  }
}
