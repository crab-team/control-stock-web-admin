import 'dart:async';

import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/toasts/toasts_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:control_stock_web_admin/utils/toast_utils.dart';
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
      return either.fold((l) => throw l, (r) => purchases = r);
    });
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

  delete(int purchaseId, int customerId) async {
    _showToast(ToastController(Texts.purchases, '${Texts.deletingPurchase} $purchaseId', ToastType.info));
    state = await AsyncValue.guard(() async {
      final either = await ref.read(deletePurchaseUseCaseProvider).execute(customerId, purchaseId);
      return either.fold((l) {
        _showToast(ToastController(Texts.purchases, '${Texts.errorDeletingPurchase} $purchaseId', ToastType.error));
        throw l;
      }, (_) {
        purchases.removeWhere((element) => element.id == purchaseId);
        _showToast(ToastController(Texts.purchases, '${Texts.purchaseDeleted} $purchaseId', ToastType.success));
        return purchases;
      });
    });

    await ref.read(customersControllerProvider.notifier).getAll();
    await ref.read(productsControllerProvider.notifier).getAll();
  }

  _showToast(ToastController toastController) {
    ref.read(toastsControllerProvider.notifier).showToast(toastController);
  }
}
