import 'package:control_stock_web_admin/presentation/widgets/products/products_data_table.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
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
