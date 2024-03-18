import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/hooks/dialogs_hook.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(categoriesControllerProvider, (previous, next) {
      if (previous != null && previous.isLoading) {
        Navigator.of(context).pop();
      }

      next.maybeWhen(
        data: (data) => ref.read(navigationServiceProvider).goToCategories(context),
        loading: () => useDialogs(context, type: DialogType.loading, content: const Text("Creando categoría")),
        error: (error, _) => useDialogs(context, type: DialogType.error, content: Text(error.toString())),
        orElse: () {},
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Texts.createCategory,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: colorScheme.secondary),
        ),
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
      ref.read(categoriesControllerProvider.notifier).create(nameController.text);
    }
  }
}
