import 'package:control_stock_web_admin/presentation/widgets/products/products_app_bar.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_data_table.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_chips_filter.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProductsAppBar(),
        Gap.medium(),
        Expanded(
          child: Column(
            children: [
              ChipsFilterTabBar(),
              Gap.medium(),
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
