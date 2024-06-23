import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/users/user_controller.dart';
import 'package:control_stock_web_admin/presentation/screens/auth/email_link_confirmation_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/auth/sign_in_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/categories/categories_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/commerce/commerce_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/customers/customers_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/products/products_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/products/upload_csv_products_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/purchases/purchases_screen.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/dashboard_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/product_drawer.dart';
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
  static const String emailLinkConfirmation = 'emailLinkConfirmation/:token';
  // static const String summary = '/resumen';
  static const String purchases = '/purchases';
  static const String products = '/products';
  static const String productAnalitycs = 'product/analytics';
  static const String productsUploadCsv = 'uploadCsv';
  static const String categories = '/categories';
  static const String commerce = '/commerce';
  static const String customers = '/customers';
  static const String customerRecords = 'records';
  // static const String orders = '/ordenes';

  static const Map<String, String> names = {
    home: 'Inicio',
    purchases: 'Compras',
    signIn: 'Iniciar sesión',
    // summary: 'Resumen',
    products: 'Productos',
    productAnalitycs: 'Análisis de producto',
    productsUploadCsv: 'Subir productos',
    emailLinkConfirmation: 'Email link confirmation',
    categories: 'Categorías',
    commerce: 'Comercio',
    customers: 'Clientes',
    customerRecords: 'Registros de cliente',
    // orders: 'Órdenes de compra',
  };
}

class NavigationService {
  final Ref ref;

  NavigationService({required this.ref});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GoRouter get appRouter {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: Routes.products,
      routes: [
        GoRoute(
          path: Routes.signIn,
          name: Routes.names[Routes.signIn]!,
          routes: [
            GoRoute(
              path: Routes.emailLinkConfirmation,
              name: Routes.names[Routes.emailLinkConfirmation]!,
              builder: (context, state) {
                return EmailLinkConfirmationScreen(token: state.pathParameters['token']!);
              },
            ),
          ],
          builder: (context, state) {
            return const SignInScreen();
          },
        ),
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: navigatorKey,
          builder: (context, state, child) {
            return DashboardWidget(page: child);
          },
          branches: [
            // _ordersBranch(),
            // _summaryBranch(),
            _productsBranch(),
            // _shoppingBranch(),
            // _customersBranch(),
            _categoriesBranch(),
            _commerceBranch(),
          ],
        ),
      ],
      redirect: (context, state) async {
        final user = await ref.watch(userControllerProvider.future);
        bool hasAccessToken = user?.accessToken.isNotEmpty ?? false;
        bool isSignInScreen = state.uri.path == Routes.signIn;
        bool isEmailLinkConfirmation = state.uri.pathSegments.contains('emailLinkConfirmation');

        if (isEmailLinkConfirmation && !hasAccessToken) {
          return null;
        }

        if (!hasAccessToken && !isSignInScreen) {
          return Routes.signIn;
        }

        return null;
      },
    );
  }

  Map<String, IconData> get routesIcon => {
        Routes.signIn: Icons.login,
        // Routes.summary: PhosphorIcons.graph,
        Routes.products: PhosphorIcons.shopping_bag,
        Routes.categories: PhosphorIcons.tag,
        Routes.customers: PhosphorIcons.users,
        Routes.commerce: PhosphorIcons.house,
        // Routes.orders: PhosphorIcons.shopping_cart,
        Routes.purchases: PhosphorIcons.currency_circle_dollar,
      };

  StatefulShellBranch _shoppingBranch() {
    return StatefulShellBranch(
      initialLocation: Routes.purchases,
      routes: [
        GoRoute(
          path: Routes.purchases,
          name: Routes.names[Routes.purchases]!,
          builder: (context, state) => const PurchasesScreen(),
        ),
      ],
    );
  }

  // StatefulShellBranch _ordersBranch() {
  //   return StatefulShellBranch(
  //     initialLocation: Routes.orders,
  //     routes: [
  //       GoRoute(
  //         path: Routes.orders,
  //         name: Routes.names[Routes.orders]!,
  //         builder: (context, state) => const OrdersScreen(),
  //       ),
  //     ],
  //   );
  // }

  StatefulShellBranch _commerceBranch() {
    return StatefulShellBranch(
      initialLocation: Routes.commerce,
      routes: [
        GoRoute(
          path: Routes.commerce,
          name: Routes.names[Routes.commerce]!,
          builder: (context, state) => const CommerceScreen(),
        ),
      ],
    );
  }

  StatefulShellBranch _customersBranch() {
    return StatefulShellBranch(
      initialLocation: Routes.customers,
      routes: [
        GoRoute(
          path: Routes.customers,
          name: Routes.names[Routes.customers]!,
          builder: (context, state) => const CustomersScreen(),
          routes: [
            GoRoute(
              path: ':id/${Routes.customerRecords}',
              name: Routes.names[Routes.customerRecords]!,
              builder: (context, state) {
                // int customerId = int.parse(state.pathParameters['id']!);
                return Container();
                // return CustomerRecordsScreen(customerId: customerId);
              },
            ),
          ],
        ),
      ],
    );
  }

  StatefulShellBranch _categoriesBranch() {
    return StatefulShellBranch(
      initialLocation: Routes.categories,
      routes: [
        GoRoute(
          path: Routes.categories,
          name: Routes.names[Routes.categories]!,
          builder: (context, state) => const CategoriesScreen(),
        ),
      ],
    );
  }

  // StatefulShellBranch _summaryBranch() {
  //   return StatefulShellBranch(
  //     initialLocation: Routes.summary,
  //     routes: [
  //       GoRoute(
  //         path: Routes.summary,
  //         name: Routes.names[Routes.summary]!,
  //         builder: (context, state) {
  //           return const SummaryScreen();
  //         },
  //       ),
  //     ],
  //   );
  // }

  StatefulShellBranch _productsBranch() {
    return StatefulShellBranch(
      initialLocation: Routes.products,
      routes: [
        GoRoute(
          path: Routes.products,
          name: Routes.names[Routes.products]!,
          builder: (context, state) {
            return const ProductsScreen();
          },
          routes: [
            GoRoute(
              path: '${Routes.productAnalitycs}/:id',
              name: Routes.names[Routes.productAnalitycs]!,
              builder: (context, state) {
                if (state.extra == null) {
                  goToProducts();
                }

                Product product = state.extra as Product;
                return ProductDrawer(product: product);
              },
            ),
            GoRoute(
              path: Routes.productsUploadCsv,
              name: Routes.names[Routes.productsUploadCsv]!,
              builder: (context, state) {
                return const UploadCsvProductsScreen();
              },
            ),
          ],
        ),
      ],
    );
  }

  goToSignIn() => navigatorKey.currentContext!.go(Routes.signIn);

  // goToSummary() => navigatorKey.currentContext!.go(Routes.summary);

  goToPurchases() => navigatorKey.currentContext!.go(Routes.purchases);

  goToProducts() => navigatorKey.currentContext!.go(Routes.products);
  goToUploadCsvProducts() => navigatorKey.currentContext!.go('${Routes.products}/${Routes.productsUploadCsv}');

  goToCategories() => navigatorKey.currentContext!.go(Routes.categories);

  goToCommerce() => navigatorKey.currentContext!.go(Routes.commerce);

  goToCustomers() => navigatorKey.currentContext!.go(Routes.customers);
  goToCustomerRecords(int customerId) =>
      navigatorKey.currentContext!.go('${Routes.customers}/$customerId/${Routes.customerRecords}');

  void goBack() => navigatorKey.currentContext!.pop();
}
