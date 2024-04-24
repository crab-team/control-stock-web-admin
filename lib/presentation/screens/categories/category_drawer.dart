import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDrawer extends ConsumerStatefulWidget {
  final Category? category;

  const CategoryDrawer({super.key, this.category});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryDrawerState();
}

class _CategoryDrawerState extends ConsumerState<CategoryDrawer> {
  final formKey = GlobalKey<FormState>();
  bool isUpdating = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController percentageProfitController = TextEditingController();
  TextEditingController extraCostsController = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _initValues();
    }
  }

  void _initValues() {
    nameController.text = widget.category!.name;
    percentageProfitController.text = widget.category!.percentageProfit.toString();
    extraCostsController.text = widget.category!.extraCosts.toStringAsFixed(2).replaceAll('.', ',');
    isUpdating = widget.category != null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isUpdating ? Texts.updateCategory : Texts.createCategory,
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
                  decoration: const InputDecoration(labelText: Texts.percentageProfit, suffixText: '%'),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Texts.requiredField;
                    }
                    return null;
                  },
                ),
                const Gap.small(),
                TextFormField(
                  controller: extraCostsController,
                  decoration: const InputDecoration(labelText: Texts.extraCosts, prefixText: '\$ '),
                  inputFormatters: [FilteringTextInputFormatter.allow(currencyInputFormatter)],
                ),
                const Gap.medium(),
                const Divider(),
                const Gap.medium(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      onPressed: () => _onSubmit(),
                      label: Text(isUpdating ? Texts.updateCategory : Texts.createCategory)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSubmit() {
    String name = nameController.text;
    double percentageProfit = double.parse(percentageProfitController.text);
    double extraCosts = double.parse(extraCostsController.text.replaceAll(',', '.'));

    if (formKey.currentState!.validate()) {
      if (isUpdating) {
        ref.read(categoriesControllerProvider.notifier).updateCategory(Category(
              id: widget.category!.id,
              name: name,
              percentageProfit: percentageProfit,
              extraCosts: extraCosts,
            ));
      } else {
        ref.read(categoriesControllerProvider.notifier).create(name, percentageProfit, extraCosts);
      }
      ref.read(navigationServiceProvider).goToCategories();
      ref.read(navigationServiceProvider).goBack();
    }
  }
}
