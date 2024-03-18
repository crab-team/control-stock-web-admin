import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarUserWidget extends ConsumerWidget {
  const SidebarUserWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text('Mauro Beltrame - 12345678-9'),
        subtitle: Text('Administrador - Acceso total'),
      ),
    );
  }
}
