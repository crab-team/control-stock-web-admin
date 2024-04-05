import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/categories_app_bar.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/categories_data_table_source.dart';
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
    return PaginatedDataTable2(
      border: TableBorder(
        horizontalInside: BorderSide(color: colorScheme.primaryContainer),
        verticalInside: BorderSide(color: colorScheme.primaryContainer),
        bottom: BorderSide(color: colorScheme.primaryContainer),
        top: BorderSide(color: colorScheme.primaryContainer),
      ),
      minWidth: 1200,
      header: const CategoriesAppBar(),
      dataTextStyle: Theme.of(context).textTheme.bodyLarge,
      rowsPerPage: 20,
      wrapInCard: false,
      empty: const Center(child: Text(Texts.noCategories)),
      headingRowHeight: 42,
      headingRowColor: MaterialStateProperty.resolveWith((states) => colorScheme.primaryContainer),
      dataRowHeight: 42,
      columns: const [
        DataColumn2(
          label: Text('Nombre'),
          size: ColumnSize.L,
        ),
        DataColumn2(
          fixedWidth: 200,
          label: Text('Porcentaje de ganancia'),
          size: ColumnSize.L,
        ),
        DataColumn2(
          fixedWidth: 150,
          label: Text('Acciones'),
          size: ColumnSize.S,
        ),
      ],
      source: CategoriesDataTableSource(
        data: data,
        onDelete: _delete,
        onChangeAnyValue: (category) {
          ref.read(categoriesControllerProvider.notifier).updateCategory(category);
        },
      ),
    );
  }

  void _delete(int id) {
    ref.read(categoriesControllerProvider.notifier).delete(id);
  }
}
