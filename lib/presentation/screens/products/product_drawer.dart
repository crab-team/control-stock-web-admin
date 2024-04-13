import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/category_selector.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/image_picker_widget.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      priceController.text = widget.product!.costPrice.toString();
      stockController.text = widget.product!.stock.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product != null ? 'Editar producto' : 'Agregar producto',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap.medium(),
        const Divider(),
        const Gap.medium(),
        Expanded(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 300, child: ImagePickerWidget()),
                const Gap.medium(),
                const Divider(),
                const Gap.medium(),
                Column(
                  children: [
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
                      decoration: const InputDecoration(labelText: Texts.price, prefixText: '\$'),
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          locale: 'es_AR',
                          decimalDigits: 2,
                          symbol: '',
                          inputDirection: InputDirection.left,
                          customPattern: '\$####,##',
                        )
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Texts.requiredField;
                        }
                        return null;
                      },
                    ),
                    const Gap.small(),
                    TextFormField(
                      controller: stockController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: Texts.stock),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Texts.requiredField;
                        }
                        return null;
                      },
                    ),
                    const Gap.small(),
                    FormField<Category>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) {
                          return Texts.requiredField;
                        }
                        return null;
                      },
                      builder: (FormFieldState state) {
                        return CategorySelector(
                          initialCategory: widget.product?.category.name,
                          onCategorySelected: (value) {
                            state.didChange(value);
                            category = value;
                          },
                        );
                      },
                    ),
                    const Gap.medium(),
                    const Divider(),
                    const Gap.medium(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary),
                            icon: const Icon(Icons.cancel),
                            onPressed: () => ref.read(navigationServiceProvider).goBack(context),
                            label: const Text('Cancelar'),
                          ),
                          const Gap.small(isHorizontal: true),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary),
                            icon: const Icon(Icons.save),
                            onPressed: () => _onSubmit(),
                            label: Text(widget.product != null ? 'Editar' : 'Agregar'),
                          ),
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

  void _onSubmit() {
    if (formKey.currentState!.validate() && category != null) {
      priceController.text = priceController.text.replaceAll('.', '').replaceAll(',', '.');

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
      ref.read(navigationServiceProvider).goBack(context);
    }
  }
}
