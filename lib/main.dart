import 'dart:async';

import 'package:flutter/material.dart';
import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        runApp(const ProviderScope(child: App()));
      },
      (error, stackTrace) {
        logger.e(error.toString());
        logger.e(stackTrace.toString());
      },
    );

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(navigationServiceProvider);

    return MaterialApp.router(
      title: "Control stock",
      routerConfig: router.appRouter,
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) => child!),
          ],
        );
      },
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
