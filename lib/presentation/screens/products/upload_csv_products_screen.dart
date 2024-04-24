import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/providers/products/upload_csv_products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/category_selector.dart';
import 'package:control_stock_web_admin/presentation/widgets/upload_products_csv/upload_products_preview_data_table.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadCsvProductsScreen extends ConsumerStatefulWidget {
  const UploadCsvProductsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadCsvProductsScreenState();
}

class _UploadCsvProductsScreenState extends ConsumerState<UploadCsvProductsScreen> {
  final _formKey = GlobalKey<FormState>();
  Category? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Texts.uploadCsvProductsScreenTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => ref.read(navigationServiceProvider).goBack(),
        ),
      ),
      body: Padding(
        padding: kPaddingAppSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: CategorySelector(
                            onCategorySelected: (value) {
                              category = value;
                              setState(() {});
                            },
                          ),
                        ),
                        const Gap.medium(isHorizontal: true),
                        ElevatedButton.icon(
                            icon: const Icon(Icons.upload),
                            onPressed: () => category != null ? _upload() : null,
                            label: const Text(Texts.uploadCsv),
                            style: ElevatedButton.styleFrom(
                              enabledMouseCursor:
                                  category != null ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
                              backgroundColor: category != null ? colorScheme.primary : colorScheme.secondaryContainer,
                            )),
                      ],
                    ),
                  ),
                  const Gap.medium(),
                  const Expanded(
                    child: UploadProductsPreviewDataTable(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _upload() {
    if (_formKey.currentState!.validate()) {
      ref.read(uploadCsvProductsControllerProvider.notifier).upload(category!);
    }
  }
}
