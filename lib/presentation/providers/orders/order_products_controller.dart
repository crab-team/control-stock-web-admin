import 'package:control_stock_web_admin/domain/entities/purchase_order_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProductsControllerProvider =
    AutoDisposeNotifierProvider<OrderProductsController, List<PurchaseOrderProduct>>(OrderProductsController.new);

class OrderProductsController extends AutoDisposeNotifier<List<PurchaseOrderProduct>> {
  @override
  build() {
    return [];
  }

  void setProduct(PurchaseOrderProduct productPurchaseOrder) {
    state.removeWhere((element) => element.id == productPurchaseOrder.id);
    state = [...state, productPurchaseOrder];
  }

  void removeProduct(int productId) {
    state.removeWhere((element) => element.id == productId);
    state = [...state];
  }

  void clear() {
    state = [];
  }
}
