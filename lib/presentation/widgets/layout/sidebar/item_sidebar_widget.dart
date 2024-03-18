import 'package:flutter/material.dart';
import 'package:control_stock_web_admin/core/theme.dart';

class ItemSidebarWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isCurrent;
  final IconData? icon;

  const ItemSidebarWidget({super.key, required this.onTap, required this.title, this.isCurrent = false, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrent ? colorScheme.secondary : Colors.transparent,
      ),
      child: ListTile(
        leading: icon != null
            ? Icon(
                icon,
                color: isCurrent ? colorScheme.onSecondary : colorScheme.inversePrimary,
              )
            : null,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: isCurrent ? colorScheme.onSecondary : colorScheme.inversePrimary),
        ),
        onTap: onTap,
      ),
    );
  }
}
