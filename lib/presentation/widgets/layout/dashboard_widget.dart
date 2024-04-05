import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/sidebar/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardWidget extends ConsumerWidget {
  final StatefulNavigationShell page;

  const DashboardWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Row(
            children: [
              SizedBox(width: constraints.maxWidth * 0.15, child: SidebarWidget(navigationShell: page)),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: kPaddingAppSmall,
                      child: page,
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
