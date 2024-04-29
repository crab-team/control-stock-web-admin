import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_order_manager_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_order_manager_data_table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ProductsOrderManagerDataTable extends ConsumerStatefulWidget {
  const ProductsOrderManagerDataTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsDataTableState();
}

class _ProductsDataTableState extends ConsumerState<ProductsOrderManagerDataTable> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsOrderManagerControllerProvider);

    return state.when(
      data: (data) => buildDataTable(data),
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
    );
  }

  buildDataTable(List<ProductOrder> data) {
    return PaginatedDataTable2(
      border: dataTableDecoration['border'] as TableBorder,
      rowsPerPage: 10,
      horizontalMargin: 0,
      wrapInCard: dataTableDecoration['wrapInCard'] as bool,
      headingRowHeight: dataTableDecoration['headingRowHeight'] as double,
      dataRowHeight: dataTableDecoration['dataRowHeight'] as double,
      headingRowColor: dataTableDecoration['headingRowColor'] as MaterialStateProperty<Color>,
      empty: const Center(child: Text(Texts.noProducts)),
      columns: const [
        DataColumn2(label: Padding(padding: EdgeInsets.only(left: 8.0), child: Text(Texts.code)), size: ColumnSize.L),
        DataColumn2(label: Text(Texts.quantity), size: ColumnSize.S),
        DataColumn2(label: Text(Texts.price), size: ColumnSize.S),
        DataColumn2(label: Text(Texts.actions), size: ColumnSize.S),
      ],
      source: ProductOrderManagerDataTableSource(
        data: data,
        onClear: _clear,
        onProductSelected: (ProductOrder productOrder) => _updateProductsOrder(productOrder),
        onScanQRPressed: (ProductOrder productOrder) => addProductWithQR(productOrder),
      ),
    );
  }

  addProductWithQR(ProductOrder productOrder) async {
    var res = await showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            alignment: Alignment.topRight,
            content: SizedBox(
                width: 300,
                height: 300,
                child: SimpleBarcodeScannerPage(
                  appBarTitle: Texts.scanQR,
                  cancelButtonText: Texts.cancel,
                  scanType: ScanType.qr,
                )),
          );
        });

    if (res == null) {
      return;
    }

    String productId = res.split('/').last;
    final products = ref.read(productsControllerProvider.notifier).products;
    final product = products.firstWhere((element) => element.code == productId);
    final updatedProductOrder = productOrder.copyWith(product: product);
    _updateProductsOrder(updatedProductOrder);
  }

  void _updateProductsOrder(ProductOrder updatedProductOrder) {
    ref.read(productsOrderManagerControllerProvider.notifier).set(updatedProductOrder.copyWith(quantity: 1));
  }

  void _clear(int id) {
    ref.read(productsOrderManagerControllerProvider.notifier).clear(id);
  }
}
