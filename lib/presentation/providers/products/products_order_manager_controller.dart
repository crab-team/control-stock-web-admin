import 'package:control_stock_web_admin/presentation/widgets/products/products_order_manager_data_table_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsOrderManagerControllerProvider =
    AsyncNotifierProvider.autoDispose<ProductsOrderManagerController, List<ProductOrder>>(
        ProductsOrderManagerController.new);

class ProductsOrderManagerController extends AutoDisposeAsyncNotifier<List<ProductOrder>> {
  List<ProductOrder> productOrders = [];

  @override
  List<ProductOrder> build() {
    Future.microtask(() => _initialize());
    return productOrders;
  }

  Future<void> _initialize() async {
    await Future.wait([
      Future.microtask(() {
        List.generate(20, (index) {
          final productOrder = ProductOrder(id: index, quantity: 0);
          productOrders.add(productOrder);
        });
      })
    ]);

    state = AsyncValue.data(productOrders);
  }

  void set(ProductOrder productOrder) {
    productOrders.setAll(productOrder.id, [productOrder]);
    state = AsyncValue.data(productOrders);
  }

  void clear(int id) {
    final index = productOrders.indexWhere((element) => element.id == id);
    productOrders[index] = productOrders[index].copyWith(product: null, quantity: 0);
    state = AsyncValue.data(productOrders);
  }
}
