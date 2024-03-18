import 'package:control_stock_web_admin/presentation/screens/products_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/sign_in_confirmed_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/sign_in_screen.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/dashboard_widget.dart';
import 'package:control_stock_web_admin/providers/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService(ref: ref);
});

class Routes {
  static const String home = '/';
  static const String signIn = '/signIn';
  static const String products = '/products';
  static const String signInConfirmed = '/signIn/confirmed';

  static const Map<String, String> names = {
    home: 'Home',
    signIn: 'Sign in',
    products: 'Products',
    signInConfirmed: 'Sign in confirmed',
  };
}

class NavigationService {
  final Ref ref;

  NavigationService({required this.ref});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GoRouter get appRouter {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: Routes.signIn,
      routes: [
        GoRoute(
            path: Routes.signIn,
            name: Routes.names[Routes.signIn]!,
            builder: (context, state) => const SignInScreen(),
            routes: [
              GoRoute(
                path: 'confirmed',
                name: 'Sign in with id',
                builder: (context, state) {
                  return const SignInConfirmedScreen();
                },
              ),
            ]),
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: navigatorKey,
          builder: (context, state, child) {
            return DashboardWidget(page: child);
          },
          branches: [
            StatefulShellBranch(
              initialLocation: Routes.products,
              routes: [
                GoRoute(
                  path: Routes.products,
                  name: Routes.names[Routes.products]!,
                  builder: (context, state) => const ProductScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
      redirect: (context, state) async {
        final isLoggedIn = await ref.watch(authControllerProvider.future);
        if (!isLoggedIn && state.name != Routes.names[Routes.signIn]!) {
          return Routes.signIn;
        }

        return null;
      },
    );
  }

  Map<String, IconData> get routesIcon => {
        Routes.home: Icons.home,
        Routes.signIn: Icons.login,
        Routes.products: Icons.looks_one,
      };

  goToSignIn(BuildContext context) => context.go(Routes.signIn);
  goToSignInConfirmed(BuildContext context) => context.go(Routes.signInConfirmed);
  goToHome(BuildContext context) => context.go(Routes.home);

  void pop() => navigatorKey.currentState?.pop();
}
