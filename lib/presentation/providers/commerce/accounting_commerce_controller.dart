import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountingCommerceController =
    AsyncNotifierProvider<AccountingCommerceController, void>(AccountingCommerceController.new);

class AccountingCommerceController extends AsyncNotifier<void> {
  @override
  build() {
    return null;
  }

  Future<void> updateCashPaymentPercentage(double cashPaymentPercentage) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(updateCashPaymentPercentageUseCaseProvider).execute('1', cashPaymentPercentage);
      return result.fold((error) => throw error, (_) {});
    });
  }
}
