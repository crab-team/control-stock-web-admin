import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commerceControllerProvider = AsyncNotifierProvider<CommerceController, Commerce?>(CommerceController.new);

class CommerceController extends AsyncNotifier<Commerce?> {
  Commerce? commerce;
  @override
  build() async {
    if (commerce == null) {
      await getById('1');
    }
    return commerce;
  }

  Future<void> getById(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(getCommerceByIdUseCaseProvider).execute(id);
      return result.fold((error) => throw error, (value) => commerce = value);
    });
  }

  Future<void> updateData(Commerce updated) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(updateCommerceUseCaseProvider).execute(updated);
      return result.fold((error) => throw error, (_) => commerce = updated);
    });
  }
}
