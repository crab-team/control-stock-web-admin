import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_data_table_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/category_selector.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/add_product_button.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/print_qr_products_button.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/product_drawer.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_data_table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsDataTable extends ConsumerStatefulWidget {
  const ProductsDataTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsDataTableState();
}

class _ProductsDataTableState extends ConsumerState<ProductsDataTable> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsDataTableStateProvider);
    return _buildDataTable(state);
  }

  _buildDataTable(List<ProductDataTableModel> data) {
    return PaginatedDataTable2(
      border: dataTableDecoration['border'] as TableBorder,
      minWidth: dataTableDecoration['minWidth'] as double,
      rowsPerPage: dataTableDecoration['rowsPerPage'] as int,
      wrapInCard: dataTableDecoration['wrapInCard'] as bool,
      headingRowHeight: dataTableDecoration['headingRowHeight'] as double,
      dataRowHeight: dataTableDecoration['dataRowHeight'] as double,
      headingRowColor: dataTableDecoration['headingRowColor'] as MaterialStateProperty<Color>,
      empty: const Center(child: Text(Texts.noProducts)),
      header: Text(Texts.products, style: Theme.of(context).textTheme.headlineMedium),
      showCheckboxColumn: true,
      columns: [
        const DataColumn2(fixedWidth: 100, label: Text('Código'), size: ColumnSize.S),
        const DataColumn2(label: Text('Nombre'), size: ColumnSize.L),
        const DataColumn2(label: Text('Precio de costo'), size: ColumnSize.S, fixedWidth: 150),
        const DataColumn2(label: Text('Precio público'), size: ColumnSize.S, fixedWidth: 150),
        DataColumn2(
          label: CategorySelector.asFilter(onCategorySelected: (category) {
            ref.read(productsControllerProvider.notifier).search(category?.name ?? '');
          }),
          size: ColumnSize.M,
        ),
        const DataColumn2(label: Text('Cantidad'), size: ColumnSize.S, fixedWidth: 120),
        const DataColumn2(fixedWidth: 80, label: Icon(PhosphorIcons.printer)),
        const DataColumn2(label: Text('Acciones'), size: ColumnSize.S, fixedWidth: 200),
      ],
      onSelectAll: (value) {
        _onSelectAllRows(data, value);
      },
      actions: [
        const VerticalDivider(indent: 8, endIndent: 8),
        SearchBar(
          leading: const Icon(PhosphorIcons.magnifying_glass),
          hintText: Texts.searchProduct,
          onChanged: (value) => _search(ref, value),
          shape: MaterialStateProperty.all<OutlinedBorder>(const LinearBorder()),
        ),
        const VerticalDivider(indent: 8, endIndent: 8),
        const AddProductButton(),
        // const UploadCsvButton(),
        const PrintQrProductsButton(),
      ],
      source: ProductDataTableSource(
        data: data,
        onDelete: _delete,
        onEdit: _onEdit,
        onAnalytics: _goToAnalitycs,
        onSelect: (productSelected) {
          _onSelectRow(data, productSelected);
        },
      ),
    );
  }

  void _search(WidgetRef ref, String query) {
    ref.read(productsControllerProvider.notifier).search(query);
  }

  void _onSelectAllRows(List<ProductDataTableModel> data, bool? value) {
    final updatedProducts = data.map((product) => product.copyWith(selected: value)).toList();
    ref.read(productsDataTableStateProvider.notifier).state = updatedProducts;
  }

  void _onSelectRow(List<ProductDataTableModel> data, String productSelected) {
    final updatedProducts = data.map((product) {
      if (product.product.code == productSelected) {
        return product.copyWith(selected: !product.selected);
      }
      return product;
    }).toList();
    ref.read(productsDataTableStateProvider.notifier).state = updatedProducts;
  }

  void _delete(int id) {
    ref.read(productsControllerProvider.notifier).delete(id);
  }

  void _onEdit(Product product) {
    ref.read(drawerControllerProvider.notifier).state = ProductDrawer(product: product);
  }

  void _goToAnalitycs(Product product) {}
}
