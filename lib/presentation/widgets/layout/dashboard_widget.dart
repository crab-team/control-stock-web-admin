import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/commerce/commerce_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/payment_methods/payment_methods_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/purchases/purchases_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/toasts/toasts_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/sidebar/sidebar_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/logo_widget.dart';
import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class DashboardWidget extends ConsumerStatefulWidget {
  final StatefulNavigationShell page;

  const DashboardWidget({super.key, required this.page});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends ConsumerState<DashboardWidget> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.wait([
      ref.read(commerceControllerProvider.future),
      ref.read(categoriesControllerProvider.future),
      ref.read(productsControllerProvider.future),
      ref.read(customersControllerProvider.future),
      ref.read(paymentMethodsControllerProvider.future),
      ref.read(purchasesControllerProvider.future),
    ]).whenComplete(() => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? _buildLoading() : _buildDashboard(context, ref);
  }

  Widget _buildDashboard(BuildContext context, WidgetRef ref) {
    ref.listen(toastsControllerProvider, (prev, next) {
      if (next != null) {
        ToastUtils.showToast(context, next.title, next.message, next.type);
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          ref.read(drawerControllerProvider.notifier).state = null;
        }
      },
      endDrawerEnableOpenDragGesture: false,
      endDrawer: _buildDrawer(ref),
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Row(
            children: [
              SizedBox(width: constraints.maxWidth * 0.15, child: SidebarWidget(navigationShell: widget.page)),
              Expanded(
                child: widget.page,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLoading() {
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

  Widget _buildDrawer(WidgetRef ref) {
    final drawerControllerListener = ref.watch(drawerControllerProvider);
    if (drawerControllerListener != null) {
      _scaffoldKey.currentState!.openEndDrawer();
    }

    return Drawer(
      width: 720,
      child: Padding(padding: kPaddingAppSmall, child: drawerControllerListener),
    );
  }
}
