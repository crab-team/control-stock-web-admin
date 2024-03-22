import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/utils/price_formatter.dart';
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
      data: (infractions) {
        return _buildDataTable(infractions);
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

    return DataTable2(
      showBottomBorder: false,
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      dataTextStyle: Theme.of(context).textTheme.bodyLarge,
      columns: const [
        DataColumn2(
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
        ),
        DataColumn2(
          label: Text('Categoria'),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text('Cantidad'),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text('Imagen'),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text('Acciones'),
          size: ColumnSize.S,
        ),
      ],
      rows: data.isEmpty
          ? const [
              DataRow(
                cells: [
                  DataCell(Text(Texts.noProducts)),
                ],
              ),
            ]
          : List<DataRow>.generate(
              data.length,
              (index) {
                return DataRow(
                  cells: [
                    DataCell(Text(data[index].code.toUpperCase())),
                    DataCell(Text(data[index].name.toUpperCase())),
                    DataCell(Text(PriceFormatter.formatPrice(data[index].price))),
                    DataCell(Text(data[index].category.toUpperCase())),
                    DataCell(_buildStock(data[index].stock)),
                    DataCell(
                        data[index].imageUrl == '' ? const Text(Texts.noImage) : Image.network(data[index].imageUrl)),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(PhosphorIcons.pencil),
                          onPressed: () => _onUpdate(data[index]),
                        ),
                        ButtonWithConfirmation(
                          onConfirm: () => _delete(data[index].id as String),
                        ),
                      ],
                    )),
                  ],
                );
              },
            ),
    );
  }

  _buildStock(int stock) {
    return Center(
      child: Text(
        stock.toString(),
        style: TextStyle(color: stock > 0 ? Colors.green : Colors.red),
      ),
    );
  }

  void _delete(String id) {
    ref.read(productsControllerProvider.notifier).delete(id);
  }

  void _onUpdate(Product product) {
    ref.read(navigationServiceProvider).goToProduct(context, product);
  }
}
