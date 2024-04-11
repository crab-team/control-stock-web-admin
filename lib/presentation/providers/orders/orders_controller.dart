import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
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
}
