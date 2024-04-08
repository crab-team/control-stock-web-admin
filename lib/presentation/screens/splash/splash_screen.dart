import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/commerce/commerce_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.microtask(() async {
      await ref.read(categoriesControllerProvider.future);
      await ref.read(productsControllerProvider.future);
      await ref.read(customersControllerProvider.future);
      await ref.read(commerceControllerProvider.future);
      await Future.delayed(const Duration(seconds: 2));
    }).then((value) => ref.read(navigationServiceProvider).goToProducts(context));

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: colorScheme.background,
        child: const Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget.vertical(
              size: 72,
            ),
            Gap.medium(),
            CircularProgressIndicator(),
          ],
        )),
      );
    });
  }
}
