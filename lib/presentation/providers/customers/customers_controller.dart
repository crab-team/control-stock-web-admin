import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customersControllerProvider = AsyncNotifierProvider<CustomersController, List<Customer>>(CustomersController.new);

class CustomersController extends AsyncNotifier<List<Customer>> {
  List<Customer> customers = [];

  @override
  build() async {
    if (customers.isEmpty) {
      await getAll();
    }

    return customers;
  }

  Future<void> getAll() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(getCustomersUseCaseProvider).execute();
      return response.fold(
        (l) => throw Exception('Error'),
        (r) => customers = r,
      );
    });
  }

  Future<void> create(Customer customer) async {
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
    if (query.isEmpty) {
      state = AsyncValue.data(customers);
      return;
    }

    state = AsyncValue.data(
      customers.where((element) {
        final byName = element.fullName.toLowerCase().contains(query.toLowerCase());
        final byPhone = element.phone?.contains(query) ?? false;
        final byEmail = element.email?.contains(query) ?? false;

        return byName || byPhone || byEmail;
      }).toList(),
    );
  }
}
