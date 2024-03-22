import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/category_selector.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  final Product? product;
  const ProductScreen({super.key, this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
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
      priceController.text = widget.product!.price.toString();
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
        const Gap.large(),
        Expanded(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(child: ImagePickerWidget()),
                    const Gap.medium(isHorizontal: true),
                    Expanded(
                      child: Column(
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
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
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
                                initialCategory: widget.product?.category,
                                onCategorySelected: (value) {
                                  state.didChange(value);
                                  category = value;
                                },
                              );
                            },
                          ),
                          const Gap.small(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.save),
                              onPressed: () => _onSubmit(),
                              label: Text(widget.product != null ? 'Editar' : 'Agregar'),
                            ),
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
      final product = Product(
        id: widget.product?.id,
        code: codeController.text,
        name: nameController.text,
        price: double.parse(priceController.text),
        stock: int.parse(stockController.text),
        category: category!.name,
        imageUrl: '',
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
