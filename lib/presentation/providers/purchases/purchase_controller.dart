import 'dart:async';

import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_order_manager_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/purchases/purchases_controller.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final purchaseControllerProvider =
    AsyncNotifierProvider.autoDispose<PurchaseController, Purchase?>(PurchaseController.new);

class PurchaseController extends AutoDisposeAsyncNotifier<Purchase?> {
  @override
  FutureOr<Purchase?> build() async {
    _listenProducts();

    return state.asData?.value ??
        Purchase(
          customer: null,
          purchaseProducts: [],
          paymentMethod: null,
          totalShopping: 0,
          status: PurchaseStatus.pending,
        );
  }

  _listenProducts() {
    ref.listen(
      productsOrderManagerControllerProvider,
      (prev, next) {
        if (next.hasValue) {
          final products = next.value ?? [];
          final subtotal = calculateSubtotal(products);
          final updatedPurchase = state.asData!.value?.copyWith(
            purchaseProducts: products,
            subtotalShopping: subtotal,
          );
          state = AsyncValue.data(updatedPurchase);
          Future.microtask(() => setTotalShopping());
        }
      },
    );
  }

  getProduct(int id) {
    if (state.asData!.value == null) {
      return null;
    }

    PurchaseProduct product = state.asData!.value!.purchaseProducts.firstWhere((element) => element.viewId == id);
    return product;
  }

  setCustomer(Customer customer) {
    final updated = state.asData!.value!.copyWith(customer: customer);
    state = AsyncValue.data(updated);
  }

  setPaymentMethod(PaymentMethod paymentMethod) {
    final updated = state.asData!.value!.copyWith(paymentMethod: paymentMethod);
    state = AsyncValue.data(updated);
    setTotalShopping();
  }

  calculateSubtotal(List<PurchaseProduct> products) {
    final subtotal = products.fold<double>(
      0,
      (previousValue, element) => previousValue + ((element.unitPrice ?? 0) * (element.quantity ?? 0)),
    );
    return subtotal;
  }

  setCustomerPayAmount(double amount) {
    double balance = state.asData!.value!.customer!.balance;
    double total = state.asData!.value!.totalShopping!;
    double debt = total;
    if (balance >= total) {
      debt = 0;
    } else {
      debt = total - balance;
    }

    Purchase updated = state.asData!.value!.copyWith(debt: debt);
    state = AsyncValue.data(updated);
  }

  setTotalShopping() {
    final subtotal = state.asData!.value?.subtotalShopping ?? 0;
    final total = subtotal * (state.asData!.value?.paymentMethod?.surchargePercentage ?? 1);
    state = AsyncValue.data(state.asData!.value!.copyWith(totalShopping: total));
  }

  confirmPurchase() async {
    Purchase updated = state.asData!.value!.copyWith(status: PurchaseStatus.confirmed);
    state = await AsyncValue.guard(() async {
      final response = await ref.read(confirmPurchaseUseCaseProvider).execute(updated);
      return response.fold((l) => state.asData!.value, (r) => updated);
    });

    ref.read(purchasesControllerProvider.notifier).getAll();
  }
}
