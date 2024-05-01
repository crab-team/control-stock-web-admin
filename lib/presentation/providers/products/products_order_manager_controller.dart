import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsOrderManagerControllerProvider =
    AsyncNotifierProvider.autoDispose<ProductsOrderManagerController, List<PurchaseProduct>>(
        ProductsOrderManagerController.new);

class ProductsOrderManagerController extends AutoDisposeAsyncNotifier<List<PurchaseProduct>> {
  List<PurchaseProduct> purchaseProducts = [];

  @override
  List<PurchaseProduct> build() {
    Future.microtask(() => _initialize());
    return purchaseProducts;
  }

  Future<void> _initialize() async {
    await Future.wait([
      Future.microtask(() {
        final purchaseProduct = PurchaseProduct(viewId: 0);
        purchaseProducts.add(purchaseProduct);
      })
    ]);

    state = AsyncValue.data(purchaseProducts);
  }

  void set(PurchaseProduct purchaseProduct) {
    final index = purchaseProducts.indexWhere((element) => element.viewId == purchaseProduct.viewId);
    purchaseProducts[index] = purchaseProduct;
    print(purchaseProducts.map((e) => e.toJson()));
    state = AsyncValue.data(purchaseProducts);
  }

  void addEmptyProduct() {
    final purchaseProduct =
        PurchaseProduct(viewId: purchaseProducts.length, quantity: 0, unitPrice: 0.0, code: '', name: '');
    purchaseProducts.add(purchaseProduct);
    state = AsyncValue.data(purchaseProducts);
  }

  void clear(int id) {
    final index = purchaseProducts.indexWhere((element) => element.viewId == id);
    purchaseProducts[index] = purchaseProducts[index].copyWith(quantity: 0, unitPrice: 0.0, code: '', name: '');
    state = AsyncValue.data(purchaseProducts);
  }
}
