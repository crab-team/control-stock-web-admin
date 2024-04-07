import 'package:control_stock_web_admin/domain/entities/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ordersControllerProvider = NotifierProvider<OrdersController, List<Order>>(OrdersController.new);

class OrdersController extends Notifier<List<Order>> {
  @override
  build() {
    return [];
  }

  void addOrder(Order order) {
    order = order.copyWith(id: state.length + 1);
    state = [...state, order];
  }
}
