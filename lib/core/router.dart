import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/screens/auth/email_link_confirmation_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/auth/sign_in_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/auth/verify_email_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/categories/categories_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/commerce/commerce_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/customers/customer_records_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/customers/customers_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/orders/orders_screen.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/product_drawer.dart';
import 'package:control_stock_web_admin/presentation/screens/products/products_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/products/upload_csv_products_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/purchases/purchases_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/splash/splash_screen.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService(ref: ref);
});

class Routes {
  static const String splash = '/';
  static const String signIn = '/signIn';
  static const String verifyEmail = 'verifyEmail';
  static const String emailLinkConfirmation = '/emailLinkConfirmation/:token';
  static const String home = '/home';
  static const String purchases = '/purchases';
  static const String products = '/products';
  static const String productAnalitycs = 'product/analytics';
  static const String productsUploadCsv = 'uploadCsv';
  static const String categories = '/categories';
  static const String commerce = '/commerce';
  static const String customers = '/customers';
  static const String customerRecords = 'records';
  static const String orders = '/ordenes';

  static const Map<String, String> names = {
    splash: 'Splash',
    home: 'Inicio',
    purchases: 'Compras',
    signIn: 'Iniciar sesión',
    products: 'Productos',
    productAnalitycs: 'Análisis de producto',
    productsUploadCsv: 'Subir productos',
    verifyEmail: 'Verificar email',
    emailLinkConfirmation: 'Email link confirmation',
    categories: 'Categorías',
    commerce: 'Comercio',
    customers: 'Clientes',
    customerRecords: 'Registros de cliente',
    orders: 'Órdenes de compra',
  };
}

class NavigationService {
  final Ref ref;

  NavigationService({required this.ref});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GoRouter get appRouter {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: Routes.splash,
      routes: [
        GoRoute(
          path: Routes.emailLinkConfirmation,
          name: Routes.names[Routes.emailLinkConfirmation]!,
          builder: (context, state) {
            return EmailLinkConfirmationScreen(token: state.pathParameters['token']!);
          },
        ),
        GoRoute(
            path: Routes.signIn,
            name: Routes.names[Routes.signIn]!,
            builder: (context, state) => const SignInScreen(),
            routes: [
              GoRoute(
                path: Routes.verifyEmail,
                name: Routes.names[Routes.verifyEmail]!,
                builder: (context, state) {
                  return const VerifyEmailScreen();
                },
              ),
            ]),
        GoRoute(
          path: Routes.splash,
          name: Routes.names[Routes.splash]!,
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: navigatorKey,
          builder: (context, state, child) {
            return DashboardWidget(page: child);
          },
          branches: [
            _ordersBranch(),
            _shoppingBranch(),
            _productsBranch(),
            _customersBranch(),
            _categoriesBranch(),
            _commerceBranch(),
          ],
        ),
      ],
      redirect: (context, state) async {
        // final token = state.pathParameters['token'];
        // User? user = await ref.watch(userControllerProvider.future);
        // bool hasSavedUser = user != null;
        // bool isSignInScreen = state.uri.path == Routes.signIn;
        // bool isSignInConfirmed = state.uri.path == Routes.verifyEmail;

        // if (!hasSavedUser && !isSignInScreen && !isSignInConfirmed) {
        //   return Routes.signIn;
        // }

        return null;
      },
    );
  }

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

  StatefulShellBranch _ordersBranch() {
    return StatefulShellBranch(
      initialLocation: Routes.orders,
      routes: [
        GoRoute(
          path: Routes.orders,
          name: Routes.names[Routes.orders]!,
          builder: (context, state) => const OrdersScreen(),
        ),
      ],
    );
  }

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
                int customerId = int.parse(state.pathParameters['id']!);
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
                  goToProducts(context);
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

  Map<String, IconData> get routesIcon => {
        Routes.splash: Icons.home,
        Routes.signIn: Icons.login,
        Routes.products: PhosphorIcons.shopping_bag,
        Routes.categories: PhosphorIcons.tag,
        Routes.customers: PhosphorIcons.users,
        Routes.commerce: PhosphorIcons.house,
        Routes.orders: PhosphorIcons.shopping_cart,
        Routes.purchases: PhosphorIcons.currency_circle_dollar,
      };

  goToSignIn(BuildContext context) => context.go(Routes.signIn);
  goToVerifyEmail(BuildContext context) => context.go('${Routes.signIn}/${Routes.verifyEmail}');

  goToHome(BuildContext context) => context.go(Routes.splash);

  goToPurchases(BuildContext context) => context.go(Routes.purchases);

  goToProducts(BuildContext context) => context.go(Routes.products);
  goToUploadCsvProducts(BuildContext context) => context.go('${Routes.products}/${Routes.productsUploadCsv}');

  goToCategories(BuildContext context) => context.go(Routes.categories);

  goToCommerce(BuildContext context) => context.go(Routes.commerce);

  goToCustomers(BuildContext context) => context.go(Routes.customers);
  goToCustomerRecords(BuildContext context, int customerId) =>
      context.go('${Routes.customers}/$customerId/${Routes.customerRecords}');

  void goBack(BuildContext context) => context.pop();
}
