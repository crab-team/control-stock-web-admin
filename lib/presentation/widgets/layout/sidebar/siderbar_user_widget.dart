import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/presentation/providers/users/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarUserWidget extends ConsumerWidget {
  const SidebarUserWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userControllerProvider);

    return state.when(
      data: (values) {
        return _buildUser(values!);
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
    );
  }

  _buildUser(User user) {
    return Center(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(user.username),
        subtitle: const Text('Administrador - Acceso total'),
      ),
    );
  }
}
