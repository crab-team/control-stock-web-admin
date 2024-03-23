import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/presentation/providers/users/user_controller.dart';
import 'package:control_stock_web_admin/presentation/screens/categories/categories_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/categories/category_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/auth/email_link_confirmation_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/products/product_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/products/products_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/products/upload_csv_products_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/auth/verify_email_screen.dart';
import 'package:control_stock_web_admin/presentation/screens/auth/sign_in_screen.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/dashboard_widget.dart';
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
  static const String verifyEmail = 'verifyEmail';
  static const String emailLinkConfirmation = '/emailLinkConfirmation/:token';
  static const String products = '/products';
  static const String product = 'product';
  static const String productAnalitycs = 'product/analytics';
  static const String productsUploadCsv = 'uploadCsv';
  static const String createProduct = 'product/create';
  static const String categories = '/categories';
  static const String createCategory = 'createCategory';

  static const Map<String, String> names = {
    home: 'Inicio',
    signIn: 'Iniciar sesión',
    products: 'Productos',
    createProduct: 'Crear producto',
    product: 'Actualizar producto',
    productAnalitycs: 'Análisis de producto',
    productsUploadCsv: 'Subir productos',
    verifyEmail: 'Verificar email',
    emailLinkConfirmation: 'Email link confirmation',
    categories: 'Categorías',
    createCategory: 'Crear categoría',
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
                      path: Routes.createProduct,
                      name: Routes.names[Routes.createProduct]!,
                      builder: (context, state) {
                        return const ProductScreen();
                      },
                    ),
                    GoRoute(
                      path: '${Routes.product}/:id',
                      name: Routes.names[Routes.product]!,
                      builder: (context, state) {
                        if (state.extra == null) {
                          goToProducts(context);
                        }

                        Product product = state.extra as Product;
                        return ProductScreen(product: product);
                      },
                    ),
                    GoRoute(
                      path: '${Routes.productAnalitycs}/:id',
                      name: Routes.names[Routes.productAnalitycs]!,
                      builder: (context, state) {
                        if (state.extra == null) {
                          goToProducts(context);
                        }

                        Product product = state.extra as Product;
                        return ProductScreen(product: product);
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
            ),
            StatefulShellBranch(
              initialLocation: Routes.categories,
              routes: [
                GoRoute(
                  path: Routes.categories,
                  name: Routes.names[Routes.categories]!,
                  builder: (context, state) => const CategoriesScreen(),
                  routes: [
                    GoRoute(
                      path: Routes.createCategory,
                      name: Routes.names[Routes.createCategory]!,
                      builder: (context, state) {
                        return const CategoryScreen();
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
        final token = state.pathParameters['token'];
        User? user = await ref.watch(userControllerProvider.future);
        bool hasSavedToken = user != null;
        bool isSignInScreen = state.uri.path == Routes.signIn;
        bool isSignInConfirmed = state.uri.path == Routes.verifyEmail;
        bool hasEmailToken = token != null;

        if (!hasSavedToken && !isSignInScreen && !isSignInConfirmed && !hasEmailToken) {
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
  goToVerifyEmail(BuildContext context) => context.go('${Routes.signIn}/${Routes.verifyEmail}');

  goToHome(BuildContext context) => context.go(Routes.home);

  goToProducts(BuildContext context) => context.go(Routes.products);
  goToProduct(BuildContext context, Product product) =>
      context.go('${Routes.products}/${Routes.product}/${product.id}', extra: product);
  goToCreateProduct(BuildContext context) => context.go('${Routes.products}/${Routes.createProduct}');
  goToProductAnalytics(BuildContext context, Product product) =>
      context.go('${Routes.products}/${Routes.product}/${product.id}/analytics');
  goToUploadCsvProducts(BuildContext context) => context.go('${Routes.products}/${Routes.productsUploadCsv}');

  goToCategories(BuildContext context) => context.go(Routes.categories);
  goToCreateCategory(BuildContext context) => context.go('${Routes.categories}/${Routes.createCategory}');

  void goBack(BuildContext context) => context.pop();
}
