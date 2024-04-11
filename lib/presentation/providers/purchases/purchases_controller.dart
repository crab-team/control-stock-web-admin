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
}
