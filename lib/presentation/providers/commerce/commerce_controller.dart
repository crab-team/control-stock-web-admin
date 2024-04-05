import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commerceController = AsyncNotifierProvider<CommerceController, Commerce?>(CommerceController.new);

class CommerceController extends AsyncNotifier<Commerce?> {
  @override
  build() async {
    const id = '1';
    await getById(id);
    return state.asData?.value;
  }

  Future<void> getById(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(getCommerceByIdUseCaseProvider).execute(id);
      return result.fold((error) => throw error, (commerce) => commerce);
    });
  }

  Future<void> updateCashPaymentPercentage(double cashPaymentPercentage) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(updateCashPaymentPercentageUseCaseProvider).execute(cashPaymentPercentage);
      return result.fold((error) => throw error, (_) => state.asData?.value);
    });
  }
}
