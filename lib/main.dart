import 'dart:async';

import 'package:flutter/material.dart';
import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        setPathUrlStrategy();
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
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
      routeInformationParser: router.appRouter.routeInformationParser,
      routerDelegate: router.appRouter.routerDelegate,
      routeInformationProvider: router.appRouter.routeInformationProvider,
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
