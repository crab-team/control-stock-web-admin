import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/categories_appbar.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/categories_data_table.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: kPaddingAppSmall.copyWith(top: 12, bottom: 12),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(kRadiusCornerOutside),
          ),
          child: const CategoriesAppBar(),
        ),
        const Gap.medium(),
        const SizedBox(
          height: 500,
          child: Card(
            child: Padding(
              padding: kPaddingAppSmall,
              child: CategoriesDataTable(),
            ),
          ),
        )
      ],
    );
  }
}
