import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/add_category_button.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/categories_data_table_source.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
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
      border: dataTableDecoration['border'] as TableBorder,
      minWidth: dataTableDecoration['minWidth'] as double,
      rowsPerPage: dataTableDecoration['rowsPerPage'] as int,
      wrapInCard: dataTableDecoration['wrapInCard'] as bool,
      headingRowHeight: dataTableDecoration['headingRowHeight'] as double,
      dataRowHeight: dataTableDecoration['dataRowHeight'] as double,
      headingRowColor: dataTableDecoration['headingRowColor'] as MaterialStateProperty<Color>,
      actions: [
        Expanded(
          child: SearchBar(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const LinearBorder(),
            ),
            leading: const Icon(PhosphorIcons.magnifying_glass),
            hintText: Texts.searchCategory,
            onChanged: (value) => _search(value),
          ),
        ),
        const Gap.medium(isHorizontal: true),
        const AddCategoryButton(),
      ],
      header: Text(
        Texts.categories,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      empty: const Center(child: Text(Texts.noCategories)),
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

  void _search(String value) {
    ref.read(categoriesControllerProvider.notifier).search(value);
  }

  void _delete(int id) {
    ref.read(categoriesControllerProvider.notifier).delete(id);
  }
}
