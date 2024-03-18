import 'package:control_stock_web_admin/presentation/widgets/layout/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/sidebar/sidebar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardWidget extends ConsumerWidget {
  final StatefulNavigationShell page;

  const DashboardWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageName = page.route.branches[page.currentIndex].defaultRoute!.name!;

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Row(
            children: [
              SizedBox(width: constraints.maxWidth * 0.2, child: SidebarWidget(navigationShell: page)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppBarWidget(currentRoute: currentPageName),
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: kPaddingApp.copyWith(top: 24),
                            child: page,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
