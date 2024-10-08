import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/products/upload_csv_products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/upload_products_csv/csv_data_table_view_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadProductsPreviewDataTable extends ConsumerStatefulWidget {
  const UploadProductsPreviewDataTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadProductsPreviewDataTableState();
}

class _UploadProductsPreviewDataTableState extends ConsumerState<UploadProductsPreviewDataTable> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(uploadCsvProductsControllerProvider);

    return state.when(
      data: (value) {
        return _buildDataTable(value);
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return Center(child: Text('$error'));
      },
    );
  }

  _buildDataTable(List<Product> data) {
    if (data.isEmpty) {
      return const Center(child: Text(Texts.noProducts));
    }

    int countAnomalies = data.where((element) {
      return element.name.isEmpty ||
          element.costPrice == 0 ||
          element.stock == 0 ||
          RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$£ï¿½]').hasMatch(element.name) ||
          RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$£ï¿½]').hasMatch(element.code);
    }).length;

    return Column(
      children: [
        Expanded(
          child: PaginatedDataTable2(
            border: TableBorder(
              horizontalInside: BorderSide(color: colorScheme.secondaryContainer),
              verticalInside: BorderSide(color: colorScheme.secondaryContainer),
              bottom: BorderSide(color: colorScheme.secondaryContainer),
              top: BorderSide(color: colorScheme.secondaryContainer),
            ),
            minWidth: 1200,
            dataTextStyle: Theme.of(context).textTheme.bodyLarge,
            columnSpacing: 12,
            header: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Hay $countAnomalies anomalias',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Gap.small(isHorizontal: true),
                Tooltip(
                  message:
                      'Aquellas filas que tengan algún campo vacío, valor en 0 \no caracteres especiales (ejemplo: !@#<>?":_`~;|=+*&^%£ï¿½),\nserán marcadas en naranja como aviso de que pueden contener errores que impidan su guardado.',
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12,
                    child: Icon(
                      PhosphorIcons.info,
                      size: 24,
                      color: colorScheme.tertiary,
                    ),
                  ),
                )
              ],
            ),
            columns: const [
              DataColumn2(
                fixedWidth: 100,
                label: Text('Código'),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text('Nombre'),
                size: ColumnSize.L,
              ),
              DataColumn2(
                fixedWidth: 200,
                label: Text('Precio'),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text('Categoria'),
                size: ColumnSize.S,
              ),
              DataColumn2(
                fixedWidth: 150,
                label: Text('Cantidad'),
                size: ColumnSize.S,
              ),
              DataColumn2(
                fixedWidth: 100,
                label: Text('Acciones'),
                size: ColumnSize.S,
              ),
            ],
            empty: const Text(Texts.noProducts),
            source: CSVDataTableViewSource(
              data: data,
              onDelete: (code) {
                ref.read(uploadCsvProductsControllerProvider.notifier).delete(code);
              },
              onChangeAnyValue: (code, valueModified, value) {
                ref.read(uploadCsvProductsControllerProvider.notifier).changeAnyValue(code, valueModified, value);
              },
            ),
          ),
        ),
        const Gap.medium(),
        Align(
          alignment: Alignment.bottomRight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: colorScheme.tertiary),
                icon: const Icon(Icons.cancel),
                onPressed: () => ref.read(uploadCsvProductsControllerProvider.notifier).clear(),
                label: const Text(Texts.cancel),
              ),
              const Gap.medium(isHorizontal: true),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                onPressed: () async => await ref.read(uploadCsvProductsControllerProvider.notifier).saveCsvProducts(),
                label: const Text(Texts.save),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
