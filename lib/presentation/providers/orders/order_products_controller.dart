import 'package:control_stock_web_admin/domain/entities/product_order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProductsControllerProvider =
    AutoDisposeNotifierProvider<OrderProductsController, List<ProductPurchaseOrder>>(OrderProductsController.new);

class OrderProductsController extends AutoDisposeNotifier<List<ProductPurchaseOrder>> {
  @override
  build() {
    return [];
  }

  void setProduct(ProductPurchaseOrder productPurchaseOrder) {
    state.removeWhere((element) => element.id == productPurchaseOrder.id);
    state = [...state, productPurchaseOrder];
  }

  void removeProduct(int productId) {
    state.removeWhere((element) => element.id == productId);
  }

  void clear() {
    state = [];
  }
}
