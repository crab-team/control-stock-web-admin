import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customersControllerProvider = AsyncNotifierProvider<CustomersController, List<Customer>>(CustomersController.new);

class CustomersController extends AsyncNotifier<List<Customer>> {
  @override
  build() async {
    if (state.asData != null) return state.asData!.value;
    await getClients();
    return state.asData!.value;
  }

  Future<void> getClients() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(getCustomersUseCaseProvider).execute();
      return response.fold(
        (l) => throw Exception('Error'),
        (r) => r,
      );
    });
  }

  Future<void> create(Customer customer) async {
    final customers = state.asData!.value;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(createCustomerUseCaseProvider).execute(customer);
      return response.fold(
        (l) => throw Exception('Error'),
        (r) => [...customers, r],
      );
    });
  }

  Future<void> updateClient(Customer customer) async {
    final customers = state.asData!.value;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(updateCustomerUseCaseProvider).execute(customer);
      return response.fold(
        (l) => throw Exception('Error'),
        (_) {
          final index = customers.indexWhere((element) => element.id == customer.id);
          customers[index] = customer;
          return customers;
        },
      );
    });
  }

  Future<void> delete(int id) async {
    final customers = state.asData!.value;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(deleteCustomerUseCaseProvider).execute(id);
      return response.fold(
        (l) => throw Exception('Error'),
        (_) {
          customers.removeWhere((element) => element.id == id);
          return customers;
        },
      );
    });
  }

  search(String query) {
    final customers = state.asData!.value;
    state = AsyncData(customers.where((element) {
      final byName = element.name.toLowerCase().contains(query.toLowerCase());
      final byLastName = element.lastName.toLowerCase().contains(query.toLowerCase());
      return byName || byLastName;
    }).toList());
  }
}
