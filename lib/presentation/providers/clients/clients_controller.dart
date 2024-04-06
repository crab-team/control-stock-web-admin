import 'package:control_stock_web_admin/domain/entities/client.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientsControllerProvider = AsyncNotifierProvider<ClientsController, List<Client>>(ClientsController.new);

class ClientsController extends AsyncNotifier<List<Client>> {
  @override
  build() async {
    await getClients();
    return state.asData!.value;
  }

  Future<void> getClients() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(getClientsUseCaseProvider).execute();
      return response.fold(
        (l) => throw Exception('Error'),
        (r) => r,
      );
    });
  }

  Future<void> create(Client client) async {
    final clients = state.asData!.value;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(createClientUseCaseProvider).execute(client);
      return response.fold(
        (l) => throw Exception('Error'),
        (r) => [...clients, r],
      );
    });
  }

  Future<void> updateClient(Client client) async {
    final clients = state.asData!.value;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(updateClientUseCaseProvider).execute(client);
      return response.fold(
        (l) => throw Exception('Error'),
        (_) {
          final index = clients.indexWhere((element) => element.id == client.id);
          clients[index] = client;
          return clients;
        },
      );
    });
  }

  Future<void> delete(int id) async {
    final clients = state.asData!.value;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(deleteClientUseCaseProvider).execute(id);
      return response.fold(
        (l) => throw Exception('Error'),
        (_) {
          clients.removeWhere((element) => element.id == id);
          return clients;
        },
      );
    });
  }

  search(String query) {
    final clients = state.asData!.value;
    state = AsyncData(clients.where((element) {
      final byName = element.name.toLowerCase().contains(query.toLowerCase());
      final byLastName = element.lastName.toLowerCase().contains(query.toLowerCase());
      return byName || byLastName;
    }).toList());
  }
}
