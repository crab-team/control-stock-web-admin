import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_order_manager_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/purchases/products_order_manager_data_table_source.dart';
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
      data: (data) => _buildDataTable(data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }

  _buildDataTable(List<PurchaseProduct> data) {
    return PaginatedDataTable2(
      border: dataTableDecoration['border'] as TableBorder,
      horizontalMargin: 0,
      hidePaginator: true,
      wrapInCard: dataTableDecoration['wrapInCard'] as bool,
      headingRowHeight: dataTableDecoration['headingRowHeight'] as double,
      dataRowHeight: dataTableDecoration['dataRowHeight'] as double,
      headingRowColor: dataTableDecoration['headingRowColor'] as WidgetStateProperty<Color>,
      empty: const Center(child: Text(Texts.noProducts)),
      header: const Text(Texts.products).headlineSmall,
      actions: [ElevatedButton(onPressed: () => _addNewProduct(), child: const Text(Texts.addProduct)).inversePrimary],
      columns: const [
        DataColumn2(label: Padding(padding: EdgeInsets.only(left: 8.0), child: Text(Texts.code)), size: ColumnSize.L),
        DataColumn2(label: Text(Texts.quantity), size: ColumnSize.S),
        DataColumn2(label: Text(Texts.price), size: ColumnSize.S),
        DataColumn2(label: Text(Texts.actions), size: ColumnSize.S),
      ],
      source: ProductOrderManagerDataTableSource(
        data: data,
        onClear: _clear,
        onProductSelected: (PurchaseProduct product) => _updateProductsOrder(product),
        onScanQRPressed: (PurchaseProduct product) => _addProductWithQR(product),
      ),
    );
  }

  _addProductWithQR(PurchaseProduct purchaseProduct) async {
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
              ),
            ),
          );
        });

    if (res == null) {
      return;
    }

    int productId = int.parse(res.split('/').last);
    final products = ref.read(productsControllerProvider.notifier).products;
    final product = products.firstWhere((element) => element.id == productId);
    final updatedProductOrder = purchaseProduct.copyWith(
      quantity: 1,
      unitPrice: product.publicPrice!,
      maxStock: product.stock,
      code: product.code,
      name: product.name,
      productId: product.id,
    );
    _updateProductsOrder(updatedProductOrder);
  }

  void _addNewProduct() {
    ref.read(productsOrderManagerControllerProvider.notifier).addEmptyProduct();
  }

  void _updateProductsOrder(PurchaseProduct updatedProduct) {
    ref.read(productsOrderManagerControllerProvider.notifier).set(updatedProduct);
  }

  void _clear(int id) {
    ref.read(productsOrderManagerControllerProvider.notifier).clear(id);
  }
}
