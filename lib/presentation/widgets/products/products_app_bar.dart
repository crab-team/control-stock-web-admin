import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/add_product_button.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/increment_percentage_cash_payment_input.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/upload_products_csv/upload_csv_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsAppBar extends ConsumerWidget {
  const ProductsAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const UploadCsvButton(),
        SearchBar(
          leading: const Icon(PhosphorIcons.magnifying_glass),
          hintText: 'Buscar producto',
          onChanged: (value) => _search(ref, value),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const LinearBorder(),
          ),
        ),
        const AddProductButton(),
        const Gap.small(isHorizontal: true),
        const IncrementPercentageCashPaymentInput(),
      ],
    );
  }

  void _search(WidgetRef ref, String query) {
    ref.read(productsControllerProvider.notifier).search(query);
  }
}
