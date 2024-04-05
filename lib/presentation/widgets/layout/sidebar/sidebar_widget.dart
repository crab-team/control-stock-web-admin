import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/sidebar/item_sidebar_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/layout/sidebar/siderbar_user_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/logo_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/version_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SidebarWidget extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const SidebarWidget({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<StatefulShellBranch> branches = navigationShell.route.branches;
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          right: BorderSide(color: colorScheme.primaryContainer),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: kPaddingAppSmall,
            child: const LogoWidget.horizontal(size: 42, withText: false),
          ),
          const Divider(),
          const SizedBox(
            width: double.maxFinite,
            height: 100,
            child: SidebarUserWidget(),
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Gap.small(),
              itemCount: branches.length,
              itemBuilder: (context, index) {
                return ItemSidebarWidget(
                  isCurrent: navigationShell.currentIndex == index,
                  title: branches[index].defaultRoute!.name!,
                  icon: ref.read(navigationServiceProvider).routesIcon[branches[index].initialLocation!],
                  onTap: () {
                    navigationShell.goBranch(index);
                  },
                );
              },
            ),
          ),
          const Padding(
            padding: kPaddingAppSmall,
            child: VersionWidget(),
          ),
        ],
      ),
    );
  }
}
