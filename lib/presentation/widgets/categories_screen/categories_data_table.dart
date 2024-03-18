import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/products_screen/delete_product_button.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesDataTable extends ConsumerStatefulWidget {
  const CategoriesDataTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoriesDataTableState();
}

class _CategoriesDataTableState extends ConsumerState<CategoriesDataTable> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesControllerProvider);

    return state.when(
      data: (data) {
        return _buildDataTable(data);
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
    );
  }

  _buildDataTable(List<Category> data) {
    if (data.isEmpty) {
      return const Center(child: Text(Texts.noProducts));
    }

    return DataTable2(
      showBottomBorder: false,
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      dataTextStyle: Theme.of(context).textTheme.bodyLarge,
      columns: const [
        DataColumn(
          label: Text('Código'),
        ),
        DataColumn2(
          label: Text('Nombre'),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text('Eliminar'),
          size: ColumnSize.S,
        ),
      ],
      rows: data.isEmpty
          ? const [
              DataRow(
                cells: [
                  DataCell(Text('No hay categorias')),
                ],
              ),
            ]
          : List<DataRow>.generate(
              data.length,
              (index) {
                return DataRow(
                  cells: [
                    DataCell(Text(data[index].id)),
                    DataCell(Text(data[index].name)),
                    DataCell(DeleteProductButton(data[index].id)),
                  ],
                );
              },
            ),
    );
  }
}
