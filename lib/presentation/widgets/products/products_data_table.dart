import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/button_with_confirmation.dart';
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
  void initState() {
    super.initState();
    Future.microtask(() => _getProducts());
  }

  void _getProducts() {
    ref.read(productsControllerProvider.notifier).getAll();
  }

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
    if (data.isEmpty) {
      return const Center(child: Text(Texts.noProducts));
    }

    return PaginatedDataTable2(
      border: TableBorder(
        horizontalInside: BorderSide(color: colorScheme.secondaryContainer),
        verticalInside: BorderSide(color: colorScheme.secondaryContainer),
        bottom: BorderSide(color: colorScheme.secondaryContainer),
      ),
      minWidth: 1200,
      dataTextStyle: Theme.of(context).textTheme.bodyLarge,
      columnSpacing: 12,
      rowsPerPage: 15,
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
          label: Text('Precio'),
          size: ColumnSize.S,
          fixedWidth: 150,
        ),
        DataColumn2(
          label: Text('Categoria'),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text('Cantidad'),
          size: ColumnSize.S,
          fixedWidth: 100,
        ),
        DataColumn2(label: Text('Acciones'), size: ColumnSize.S, fixedWidth: 200),
      ],
      source: MyDataSource(
        data: data,
        onDelete: _delete,
        onChangeAnyValue: (productUpdated) {
          ref.read(productsControllerProvider.notifier).updateProduct(productUpdated);
        },
        onEdit: _onEdit,
        onAnalytics: _goToAnalitycs,
      ),
    );
  }

  void _delete(String id) {
    ref.read(productsControllerProvider.notifier).delete(id);
  }

  void _onEdit(Product product) {
    ref.read(navigationServiceProvider).goToProduct(context, product);
  }

  void _goToAnalitycs(Product product) {
    ref.read(navigationServiceProvider).goToProductAnalytics(context, product);
  }
}

class MyDataSource extends DataTableSource {
  final List<Product> _data;
  final Function(String code) onDelete;
  final Function(Product product) onEdit;
  final Function(Product code) onAnalytics;
  final Function(Product productUpdated) onChangeAnyValue;

  MyDataSource({
    List<Product>? data,
    required this.onDelete,
    required this.onChangeAnyValue,
    required this.onEdit,
    required this.onAnalytics,
  }) : _data = data ?? <Product>[];

  @override
  int get rowCount => _data.length;

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    final product = _data[index];
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController stockController = TextEditingController();
    nameController.text = product.name.toUpperCase();
    priceController.text = product.price.toString();
    stockController.text = product.stock.toString();

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(product.code)),
        DataCell(TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) => onChangeAnyValue(product.copyWith(name: value)),
        )),
        DataCell(TextFormField(
          controller: priceController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            prefix: Text('\$ '),
          ),
          onFieldSubmitted: (value) => onChangeAnyValue(product.copyWith(price: double.tryParse(value) ?? 0.0)),
        )),
        DataCell(Text(product.category.toUpperCase())),
        DataCell(TextFormField(
          controller: stockController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) => onChangeAnyValue(product.copyWith(stock: int.tryParse(value) ?? 0)),
        )),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(PhosphorIcons.pencil),
              onPressed: () => onEdit(product),
            ),
            ButtonWithConfirmation(
              onConfirm: () => onDelete(product.code),
            ),
            IconButton(
              icon: Icon(
                PhosphorIcons.chart_pie_slice,
                color: colorScheme.secondary,
              ),
              onPressed: () => onAnalytics(product),
            ),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
