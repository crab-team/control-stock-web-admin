import 'dart:async';

import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final purchasesControllerProvider = AsyncNotifierProvider<PurchasesController, List<Purchase>>(PurchasesController.new);

class PurchasesController extends AsyncNotifier<List<Purchase>> {
  List<Purchase> purchases = [];

  @override
  FutureOr<List<Purchase>> build() async {
    if (purchases.isEmpty) {
      await getAll();
    }
    return purchases;
  }

  getAll() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final either = await ref.read(getPurchasesUseCaseProvider).execute();
      return either.fold((l) => throw l, (r) => r);
    });

    purchases = state.asData?.value ?? [];
  }

  search(String query) async {
    if (query.isEmpty) {
      state = AsyncValue.data(purchases);
      return;
    }

    state = const AsyncValue.loading();
    state = AsyncValue.data(
      purchases.where((element) {
        final byCustomer = element.fullName.toLowerCase().contains(query.toLowerCase());
        final byProductName = element.purchaseProducts
            .map((e) => e.name)
            .toSet()
            .toList()
            .join('')
            .toLowerCase()
            .contains(query.toLowerCase());
        final byCreatedAt = element.createdAt.toString().contains(query.toLowerCase());
        return byCustomer || byProductName || byCreatedAt;
      }).toList(),
    );
  }

  delete(int id, int customerId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final either = await ref.read(deletePurchaseUseCaseProvider).execute(customerId, id);
      return either.fold((l) => throw l, (_) {
        purchases.removeWhere((element) => element.id == id);
        return purchases;
      });
    });
  }
}
