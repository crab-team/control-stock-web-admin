import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order_product.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/order_products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/orders/search_product.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/number_inc_dec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductOrderSelector extends ConsumerStatefulWidget {
  final void Function(Key, int?)? onDelete;
  const ProductOrderSelector({super.key, this.onDelete});

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
    final productsSelected = ref.watch(orderProductsControllerProvider);
    final codes = productsSelected.map((e) => e.code).toList();

    return Row(
      children: [
        Expanded(
          child: SearchProduct(
            alreadySelectedProducts: codes,
            onProductSelected: (product) => _selectProduct(product),
          ),
        ),
        const Gap.small(isHorizontal: true),
        NumberIncDec(
            label: Texts.quantity,
            initialValue: _quantity,
            maxValue: _selectedProduct?.stock ?? 0,
            onChanged: (quantity) {
              _updateProductOrder(quantity);
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
        Visibility(
          visible: widget.onDelete != null,
          child: IconButton(
            icon: const Icon(PhosphorIcons.trash),
            onPressed: () => widget.onDelete == null ? {} : widget.onDelete!(widget.key!, _selectedProduct?.id),
          ),
        ),
      ],
    );
  }

  void _selectProduct(Product product) {
    _quantity = 0;
    priceController.text = '0.00';

    // This is because there is a product already selected and the admin wants to change it
    if (_selectedProduct != null) {
      ref.read(orderProductsControllerProvider.notifier).removeProduct(_selectedProduct!.id!);
    }

    _selectedProduct = product;
    setState(() {});
  }

  void _updateProductOrder(int newQuantity) {
    _quantity = newQuantity;
    if (_selectedProduct == null) {
      return;
    }

    priceController.text = ((_selectedProduct!.publicPrice ?? 0) * _quantity).toStringAsFixed(2);
    final productOrderPurchase = PurchaseOrderProduct(
      id: _selectedProduct!.id!,
      code: _selectedProduct!.code,
      quantity: _quantity,
      unitPrice: _selectedProduct!.publicPrice!,
    );

    ref.read(orderProductsControllerProvider.notifier).setProduct(productOrderPurchase);
    setState(() {});
  }
}
