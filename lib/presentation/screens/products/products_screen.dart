import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_app_bar.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_data_table.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_chips_filter.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: const ProductsAppBar(),
        ),
        const Gap.medium(),
        const Expanded(
          child: Column(
            children: [
              ChipsFilterTabBar(),
              Gap.small(),
              Expanded(
                child: ProductsDataTable(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
