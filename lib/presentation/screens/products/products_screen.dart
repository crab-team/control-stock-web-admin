import 'package:control_stock_web_admin/presentation/providers/toasts/toasts_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_data_table.dart';
import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(toastsControllerProvider, (prev, next) {
      if (next != null) {
        ToastUtils.showToast(context, next.title, next.message, next.type);
      }
    });

    return const ProductsDataTable();
  }
}
