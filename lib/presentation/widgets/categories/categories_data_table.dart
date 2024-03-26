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
    if (data.isEmpty) {
      return const Center(child: Text(Texts.noCategories));
    }

    return PaginatedDataTable2(
      border: TableBorder(
        horizontalInside: BorderSide(color: colorScheme.secondaryContainer),
        verticalInside: BorderSide(color: colorScheme.secondaryContainer),
        bottom: BorderSide(color: colorScheme.secondaryContainer),
        top: BorderSide(color: colorScheme.secondaryContainer),
      ),
      minWidth: 1200,
      dataTextStyle: Theme.of(context).textTheme.bodyLarge,
      columnSpacing: 12,
      rowsPerPage: 15,
      empty: const Center(child: Text(Texts.noProducts)),
      header: const CategoriesAppBar(),
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
