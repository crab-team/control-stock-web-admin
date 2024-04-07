import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/entities/product_order.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/order_products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/number_input.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/search_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductOrderSelector extends ConsumerStatefulWidget {
  const ProductOrderSelector({super.key});

  @override
  ConsumerState<ProductOrderSelector> createState() => _ProductOrderSelectorState();
}

class _ProductOrderSelectorState extends ConsumerState<ProductOrderSelector> {
  Product? _selectedProduct;
  final priceController = TextEditingController();
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    priceController.text = '0.00';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchProduct(onProductSelected: (product) => _selectProduct(product)),
        ),
        const Gap.small(isHorizontal: true),
        NumberInput(
            label: Texts.quantity,
            initialValue: _quantity,
            maxValue: _selectedProduct?.stock ?? 0,
            onChanged: (p0) {
              if (p0 < _quantity) {
                return _removeProduct();
              }
              _quantity = p0;
              priceController.text = ((_selectedProduct?.publicPrice ?? 0) * _quantity).toStringAsFixed(2);
              _confirmSelection();
              setState(() {});
            }),
        const Gap.small(isHorizontal: true),
        Expanded(
          child: TextFormField(
            controller: priceController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: Texts.price,
            ),
          ),
        ),
        const Gap.small(isHorizontal: true),
        IconButton(
          icon: const Icon(PhosphorIcons.trash),
          onPressed: () {
            ref.read(orderProductsControllerProvider.notifier).removeProduct(_selectedProduct!.id!);
          },
        ),
      ],
    );
  }

  void _selectProduct(Product product) {
    _quantity = 0;
    priceController.text = '0.00';
    _selectedProduct = product;
    setState(() {});
  }

  void _confirmSelection() {
    double price = double.parse(priceController.text);

    ref.read(orderProductsControllerProvider.notifier).addProduct(ProductOrder(
          id: _selectedProduct!.id!,
          code: _selectedProduct!.code,
          quantity: _quantity,
          price: price,
        ));
  }

  void _removeProduct() {
    ref.read(orderProductsControllerProvider.notifier).removeProduct(_selectedProduct!.id!);
  }
}
