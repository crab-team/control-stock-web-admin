import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/toasts/toasts_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/sidebar/sidebar_widget.dart';
import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class DashboardWidget extends ConsumerWidget {
  final StatefulNavigationShell page;

  const DashboardWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(toastsControllerProvider, (prev, next) {
      if (next != null) {
        ToastUtils.showToast(context, next.title, next.message, next.type);
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          ref.read(drawerController.notifier).state = null;
        }
      },
      endDrawerEnableOpenDragGesture: false,
      endDrawer: _buildDrawer(ref),
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Row(
            children: [
              SizedBox(width: constraints.maxWidth * 0.15, child: SidebarWidget(navigationShell: page)),
              Expanded(
                child: page,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDrawer(WidgetRef ref) {
    final drawerControllerListener = ref.watch(drawerController);
    if (drawerControllerListener != null) {
      _scaffoldKey.currentState!.openEndDrawer();
    }

    return Drawer(
      width: 720,
      child: Padding(padding: kPaddingAppSmall, child: drawerControllerListener),
    );
  }
}
