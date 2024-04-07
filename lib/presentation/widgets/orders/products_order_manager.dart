import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/orders/product_order_selector.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsManager extends ConsumerStatefulWidget {
  const ProductsManager({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsManagerState();
}

class _ProductsManagerState extends ConsumerState<ProductsManager> {
  final List<Widget> _productsItems = [];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsControllerProvider);

    return state.when(
      data: (values) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Texts.products, style: Theme.of(context).textTheme.bodyLarge),
                _buildAddProductButton(),
              ],
            ),
            const Gap.medium(),
            Expanded(
              child: ListView.separated(
                primary: false,
                separatorBuilder: (_, __) => const Column(
                  children: [Gap.small()],
                ),
                itemCount: _productsItems.length,
                itemBuilder: (_, index) => _productsItems[index],
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(error.toString())),
    );
  }

  Widget _buildAddProductButton() {
    return Column(
      children: [
        ElevatedButton.icon(
          icon: const Icon(PhosphorIcons.plus),
          label: const Text(Texts.addProduct),
          onPressed: () {
            _productsItems.add(const ProductOrderSelector());
            setState(() {});
          },
        ),
      ],
    );
  }
}
