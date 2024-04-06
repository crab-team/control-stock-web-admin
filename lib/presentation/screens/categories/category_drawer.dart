import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDrawer extends ConsumerStatefulWidget {
  const CategoryDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryDrawerState();
}

class _CategoryDrawerState extends ConsumerState<CategoryDrawer> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController percentageProfitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Texts.createCategory,
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
                  controller: percentageProfitController,
                  decoration: const InputDecoration(labelText: Texts.percentageProfit),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Texts.requiredField;
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _create(),
                ),
                const Gap.medium(),
                const Divider(),
                const Gap.medium(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      onPressed: () => _create(),
                      label: const Text(Texts.createCategory)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _create() {
    if (formKey.currentState!.validate()) {
      ref.read(categoriesControllerProvider.notifier).create(
            nameController.text,
            double.parse(percentageProfitController.text),
          );
      ref.read(navigationServiceProvider).goToCategories(context);
    }
  }
}
