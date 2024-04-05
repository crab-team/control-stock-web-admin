import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/categories/category_selector.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_app_bar.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_data_table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsDataTable extends ConsumerStatefulWidget {
  const ProductsDataTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsDataTableState();
}

class _ProductsDataTableState extends ConsumerState<ProductsDataTable> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsControllerProvider);

    return state.when(
      data: (values) {
        return _buildDataTable(values);
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
    );
  }

  _buildDataTable(List<Product> data) {
    return PaginatedDataTable2(
      border: TableBorder(
        horizontalInside: BorderSide(color: colorScheme.primaryContainer),
        verticalInside: BorderSide(color: colorScheme.primaryContainer),
        bottom: BorderSide(color: colorScheme.primaryContainer),
        top: BorderSide(color: colorScheme.primaryContainer),
      ),
      minWidth: 1200,
      dataTextStyle: Theme.of(context).textTheme.bodyLarge,
      rowsPerPage: 20,
      wrapInCard: false,
      empty: const Center(child: Text(Texts.noProducts)),
      header: const ProductsAppBar(),
      headingRowHeight: 42,
      headingRowColor: MaterialStateProperty.resolveWith((states) => colorScheme.primaryContainer),
      dataRowHeight: 42,
      columns: [
        const DataColumn2(
          fixedWidth: 50,
          label: Text('QR'),
          size: ColumnSize.S,
        ),
        const DataColumn2(
          fixedWidth: 100,
          label: Text('Código'),
          size: ColumnSize.S,
        ),
        const DataColumn2(
          label: Text('Nombre'),
          size: ColumnSize.L,
        ),
        const DataColumn2(
          label: Text('Precio de costo'),
          size: ColumnSize.S,
          fixedWidth: 150,
        ),
        const DataColumn2(
          label: Text('Precio al público'),
          size: ColumnSize.S,
          fixedWidth: 150,
        ),
        const DataColumn2(
          label: Text('Precio al público efectivo'),
          size: ColumnSize.S,
          fixedWidth: 150,
        ),
        DataColumn2(
          label: CategorySelector.asFilter(onCategorySelected: (category) {
            ref.read(productsControllerProvider.notifier).search(category?.name ?? '');
          }),
          size: ColumnSize.S,
        ),
        const DataColumn2(
          label: Text('Cantidad'),
          size: ColumnSize.S,
          fixedWidth: 120,
        ),
        const DataColumn2(label: Text('Acciones'), size: ColumnSize.S, fixedWidth: 200),
      ],
      source: ProductDataTableSource(
        data: data,
        onDelete: _delete,
        onChangeAnyValue: _update,
        onEdit: _onEdit,
        onAnalytics: _goToAnalitycs,
      ),
    );
  }

  void _delete(int id) {
    ref.read(productsControllerProvider.notifier).delete(id);
  }

  void _onEdit(Product product) {
    ref.read(navigationServiceProvider).goToProduct(context, product.id!);
  }

  void _goToAnalitycs(Product product) {
    ref.read(navigationServiceProvider).goToProductAnalytics(context, product.id!);
  }

  void _update(Product productUpdated) {
    Product product = Product(
      id: productUpdated.id,
      code: productUpdated.code,
      name: productUpdated.name,
      costPrice: productUpdated.costPrice,
      stock: productUpdated.stock,
      category: productUpdated.category,
      imageUrl: '',
    );
    ref.read(productsControllerProvider.notifier).updateProduct(product);
  }
}
