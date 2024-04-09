import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentMethodsControllerProvider =
    AsyncNotifierProvider<PaymentMethodsController, List<PaymentMethod>>(PaymentMethodsController.new);

class PaymentMethodsController extends AsyncNotifier<List<PaymentMethod>> {
  List<PaymentMethod> paymentMethods = [];

  @override
  build() async {
    if (paymentMethods.isEmpty) {
      await fetchPaymentMethods();
    }

    return paymentMethods;
  }

  Future<void> fetchPaymentMethods() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(getPaymentMethodsUseCaseProvider).execute();
      return response.fold((l) => throw Exception(l.message), (r) => paymentMethods = r);
    });
  }

  Future<void> create(PaymentMethod paymentMethod) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(createPaymentMethodUseCaseProvider).execute(paymentMethod);
      return response.fold((l) => throw Exception(l.message), (r) {
        return [...paymentMethods, r];
      });
    });
  }

  Future<void> delete(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(deletePaymentMethodUseCaseProvider).execute(id);
      paymentMethods.removeWhere((element) => element.id == id);
      return paymentMethods;
    });
  }

  Future<void> updatePayment(PaymentMethod paymentMethod) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(updatePaymentMethodUseCaseProvider).execute(paymentMethod);
      return response.fold((l) => throw Exception(l.message), (r) {
        final index = paymentMethods.indexWhere((element) => element.id == paymentMethod.id);
        paymentMethods[index] = paymentMethod;
        return paymentMethods;
      });
    });
  }
}
