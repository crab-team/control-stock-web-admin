import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/hooks/dialogs_hook.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  final Product? product;
  const ProductScreen({super.key, this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  List<String> type = [
    'Cartera',
    'Billetera',
    'Mochila',
    'Bolso',
  ];

  final formKey = GlobalKey<FormState>();
  String selectedType = '';
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(productsControllerProvider, (previous, next) {
      if (previous != null && previous.isLoading) {
        Navigator.of(context).pop();
      }

      next.maybeWhen(
        data: (data) => ref.read(navigationServiceProvider).goToProducts(context),
        loading: () => useDialogs(context, type: DialogType.loading, content: const Text("Creando producto")),
        error: (error, _) => useDialogs(context, type: DialogType.error, content: Text(error.toString())),
        orElse: () {},
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product != null ? 'Editar producto' : 'Agregar producto',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: colorScheme.secondary),
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
                            controller: nameController,
                            decoration: const InputDecoration(labelText: Texts.name),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Texts.requiredField;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap.small(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
