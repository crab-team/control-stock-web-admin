import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/screens/product_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/products_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/sign_in_confirmed_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/sign_in_screen.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/dashboard_widget.dart';
import 'package:control_stock_web_admin/providers/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService(ref: ref);
});

class Routes {
  static const String home = '/';
  static const String signIn = '/signIn';
  static const String signInConfirmed = 'confirmed';
  static const String products = '/products';
  static const String product = 'product/:id';
  static const String createProduct = 'createProduct';
  static const String categories = '/categories';
  static const String category = 'category/:id';
  static const String createCategory = 'createCategory';

  static const Map<String, String> names = {
    home: 'Inicio',
    signIn: 'Iniciar sesión',
    products: 'Productos',
    createProduct: 'Crear producto',
    product: 'Actualizar producto',
    signInConfirmed: 'Inicio de sesión confirmado',
    categories: 'Categorías',
    createCategory: 'Crear categoría',
    category: 'Actualizar categoría',
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
                path: Routes.signInConfirmed,
                name: Routes.names[Routes.signInConfirmed]!,
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
                  builder: (context, state) => const ProductsScreen(),
                  routes: [
                    GoRoute(
                      path: 'create',
                      name: Routes.names[Routes.createProduct]!,
                      builder: (context, state) {
                        return const ProductScreen();
                      },
                    ),
                    GoRoute(
                      path: Routes.product,
                      name: Routes.names[Routes.product]!,
                      builder: (context, state) {
                        Product product = state.extra as Product;
                        return ProductScreen(product: product);
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              initialLocation: Routes.categories,
              routes: [
                GoRoute(
                  path: Routes.categories,
                  name: Routes.names[Routes.categories]!,
                  builder: (context, state) => const ProductsScreen(),
                  routes: [
                    GoRoute(
                      path: Routes.createCategory,
                      name: Routes.names[Routes.createCategory]!,
                      builder: (context, state) {
                        return const ProductScreen();
                      },
                    ),
                    GoRoute(
                      path: Routes.category,
                      name: Routes.names[Routes.category]!,
                      builder: (context, state) {
                        Product product = state.extra as Product;
                        return ProductScreen(product: product);
                      },
                    ),
                  ],
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
        Routes.products: PhosphorIcons.shopping_bag,
        Routes.categories: PhosphorIcons.tag,
      };

  goToSignIn(BuildContext context) => context.go(Routes.signIn);
  goToSignInConfirmed(BuildContext context) => context.go('${Routes.signIn}/${Routes.signInConfirmed}');
  goToHome(BuildContext context) => context.go(Routes.home);
  goToProduct(BuildContext context, Product product) =>
      context.go('${Routes.products}${Routes.product}', extra: product);
  goToCreateProduct(BuildContext context) => context.go('${Routes.products}/${Routes.createProduct}');

  void pop() => navigatorKey.currentState?.pop();
}
