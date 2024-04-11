import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/orders_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerRecordsControllerProvider =
    AutoDisposeAsyncNotifierProvider<CustomerRecordsController, List<Purchase>>(CustomerRecordsController.new);

class CustomerRecordsController extends AutoDisposeAsyncNotifier<List<Purchase>> {
  List<Purchase> records = [];
  @override
  build() {
    return records;
  }

  confirmPurchase(PurchaseOrder order) async {
    // records = [...records, ...newRecords];

    // int customerId = order.customer.id!;
    // state = AsyncData(records);
    // state = await AsyncValue.guard(() async {
    //   final response = await ref.read(createCustomerRecordsUseCaseProvider).execute(customerId, newRecords);
    //   return response.fold(
    //     (l) => throw Exception('Error'),
    //     (r) async {
    //       await _updateProductsStock();
    //       _removeFromOrder(order);
    //       return r;
    //     },
    //   );
    // });
  }

  _removeFromOrder(List<PurchaseOrder> orders) {
    final ordersController = ref.read(ordersControllerProvider.notifier);
    for (var order in orders) {
      ordersController.removeOrder(order.id!);
    }
  }

  _updateProductsStock() async {
    await ref.read(productsControllerProvider.notifier).getAll();
  }

  getAllCustomerRecords(int customerId) async {
    records = state.asData!.value;
  }

  search(String query) {
    final currentRecords = state.asData!.value;

    if (query.isEmpty || query == '') {
      state = AsyncData(records);
      return;
    }

    state = AsyncData(currentRecords.where((element) {
      final byName = element.productName!.toLowerCase().contains(query.toLowerCase());
      final byCode = element.productCode!.toLowerCase().contains(query.toLowerCase());
      final byPaymentStatus = element.paymentStatus.label.toLowerCase().contains(query.toLowerCase());
      return byName || byCode || byPaymentStatus;
    }).toList());
  }
}
