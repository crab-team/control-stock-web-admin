import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/category_selector.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/number_inc_dec.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDrawer extends ConsumerStatefulWidget {
  final Product? product;
  const ProductDrawer({super.key, this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductDrawerState();
}

class _ProductDrawerState extends ConsumerState<ProductDrawer> {
  final formKey = GlobalKey<FormState>();
  String selectedType = '';
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  Category? category;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      codeController.text = widget.product!.code;
      nameController.text = widget.product!.name;
      priceController.text = widget.product!.costPrice.toStringAsFixed(2).replaceAll('.', ',');
      stockController.text = widget.product!.stock.toString();
      category = widget.product!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDrawerStateControllerProvider);

    if (state == ProductDrawerState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state == ProductDrawerState.error) {
      Future.delayed(const Duration(seconds: 2), () {
        ref.read(productDrawerStateControllerProvider.notifier).state = ProductDrawerState.initial;
        return;
      });

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: colorScheme.error),
            const Gap.small(),
            const Text('Ha ocurrido un error'),
          ],
        ),
      );
    }

    if (state == ProductDrawerState.success) {
      Future.delayed(const Duration(seconds: 2), () {
        ref.read(navigationServiceProvider).goBack();
        ref.read(drawerControllerProvider.notifier).state = null;
        return;
      });

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIcons.check_circle, color: colorScheme.success, size: 54),
            const Gap.small(),
            Text('Producto ${widget.product != null ? 'actualizado' : 'creado'} correctamente').bodyMedium,
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product != null ? 'Editar producto' : 'Agregar producto',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Gap.small(),
        const Divider(),
        const Gap.small(),
        Expanded(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                // const SizedBox(height: 300, child: ImagePickerWidget()),
                // const Gap.medium(),
                // const Divider(),
                // const Gap.medium(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FormField<Category>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      builder: (FormFieldState state) {
                        return CategorySelector(
                          initialCategory: category?.name,
                          asFilter: false,
                          hasError: state.hasError,
                          onCategorySelected: (value) {
                            state.didChange(value);
                            category = value;
                            setState(() {});
                          },
                        );
                      },
                    ),
                    _buildLastProductCreatedByCategory(),
                    const Gap.small(),
                    TextFormField(
                      controller: codeController,
                      decoration: const InputDecoration(labelText: Texts.code),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Texts.requiredField;
                        }
                        return null;
                      },
                    ),
                    const Gap.small(),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: Texts.name),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Texts.requiredField;
                        }
                        return null;
                      },
                    ),
                    const Gap.small(),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: Texts.price, prefixText: '\$ '),
                      inputFormatters: [FilteringTextInputFormatter.allow(currencyInputFormatter)],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Texts.requiredField;
                        }

                        double doubleValue = double.parse(value.replaceAll(',', '.'));
                        priceController.text = doubleValue.toStringAsFixed(2);
                        return null;
                      },
                    ),
                    const Gap.small(),
                    NumberIncDec(
                      value: widget.product?.stock ?? 0,
                      onChanged: (p0) => stockController.text = p0.toString(),
                      label: Texts.stock,
                    ),
                    const Gap.medium(),
                    const Divider(),
                    const Gap.medium(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(child: null, onPressed: () => ref.read(navigationServiceProvider).goBack())
                              .cancel,
                          const Gap.small(isHorizontal: true),
                          ElevatedButton(child: null, onPressed: () => _onSubmit()).save,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLastProductCreatedByCategory() {
    if (category == null) {
      return const SizedBox();
    }

    final lastProduct = ref.read(productsControllerProvider.notifier).getLastProductCreatedByCategory(category!.id!);
    if (lastProduct == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap.small(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Último producto creado en esta categoría:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Gap.small(isHorizontal: true),
            Text(
              '${lastProduct.code} '.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              '- ${lastProduct.name}'.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  void _onSubmit() {
    if (formKey.currentState!.validate() && category != null) {
      final product = Product(
        id: widget.product?.id,
        code: codeController.text,
        name: nameController.text,
        costPrice: double.parse(priceController.text),
        stock: int.parse(stockController.text),
        category: category!,
        imageUrl: '',
        hasQrPrinted: widget.product?.hasQrPrinted ?? false,
      );

      if (widget.product != null) {
        ref.read(productsControllerProvider.notifier).updateProduct(product);
      } else {
        ref.read(productsControllerProvider.notifier).create(product);
      }
    }
  }
}
