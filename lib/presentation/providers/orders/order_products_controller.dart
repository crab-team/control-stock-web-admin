import 'package:control_stock_web_admin/domain/entities/product_order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProductsControllerProvider =
    AutoDisposeNotifierProvider<OrderProductsController, List<ProductOrder>>(OrderProductsController.new);

class OrderProductsController extends AutoDisposeNotifier<List<ProductOrder>> {
  @override
  build() {
    return [];
  }

  void addProduct(ProductOrder product) {
    state = [...state, product];
  }

  void removeProduct(int productId) {
    state = state.where((element) => element.id != productId).toList();
  }

  void updateProduct(ProductOrder product) {
    state = state.map((e) => e.id == product.id ? product : e).toList();
  }

  void clear() {
    state = [];
  }
}
