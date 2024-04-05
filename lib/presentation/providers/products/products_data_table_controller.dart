import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/products/products_data_table_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsDataTableStateProvider = StateProvider.autoDispose<List<ProductDataTableModel>>((ref) {
  final products = ref.watch(productsControllerProvider);
  return products.when(
    data: (data) {
      return data.map((product) => ProductDataTableModel(product: product)).toList();
    },
    loading: () => [],
    error: (error, stackTrace) {
      return [];
    },
  );
});
