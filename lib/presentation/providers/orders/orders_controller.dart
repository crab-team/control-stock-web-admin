import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ordersControllerProvider = NotifierProvider<OrdersController, List<PurcharseOrder>>(OrdersController.new);

class OrdersController extends Notifier<List<PurcharseOrder>> {
  @override
  build() {
    return [];
  }

  addOrder(PurcharseOrder order) async {
    order = order.copyWith(id: state.length + 1);
    state = [...state, order];
  }

  removeOrder(PurcharseOrder order) async {
    state = state.where((element) => element.id != order.id).toList();
  }
}
