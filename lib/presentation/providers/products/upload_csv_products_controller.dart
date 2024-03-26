import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:control_stock_web_admin/utils/products_csv_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadCsvProductsControllerProvider =
    AutoDisposeAsyncNotifierProvider<UploadCsvProductsController, List<Product>>(UploadCsvProductsController.new);

class UploadCsvProductsController extends AutoDisposeAsyncNotifier<List<Product>> {
  @override
  build() {
    return [];
  }

  upload(Category category) async {
    try {
      state = const AsyncValue.loading();
      final csv = await ProductsCsvLoader.upload();
      List<Product> products = [];

      csv.fold(
        (l) => state = AsyncValue.error(l.message, StackTrace.current),
        (r) {
          products = r
              .map((e) => Product(
                    code: e.code!,
                    name: e.name!,
                    category: category,
                    costPrice: e.price!,
                    stock: e.stock!,
                    imageUrl: '',
                  ))
              .toList();
          state = AsyncValue.data(products);
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  delete(String code) {
    final products = state.asData!.value;
    final product = products.firstWhere((element) => element.code == code);
    products.remove(product);
    state = AsyncValue.data(products);
  }

  changeAnyValue(String code, String valueModified, String value) {
    final products = state.asData!.value;
    final product = products.firstWhere((element) => element.code == code);
    final index = products.indexOf(product);
    switch (valueModified) {
      case 'code':
        products[index] = product.copyWith(code: value);
        break;
      case 'name':
        products[index] = product.copyWith(name: value);
        break;
      case 'price':
        products[index] = product.copyWith(costPrice: double.tryParse(value) ?? 0.0);
        break;
      case 'stock':
        products[index] = product.copyWith(stock: int.tryParse(value) ?? 0);
        break;
    }

    state = AsyncValue.data(products);
  }

  saveCsvProducts() async {
    final products = state.asData!.value;
    try {
      state = const AsyncValue.loading();
      final result = await ref.read(createProductsUseCaseProvider).execute(products);
      result.fold(
        (l) => state = AsyncValue.error(l.message, StackTrace.current),
        (r) => state = const AsyncValue.data([]),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  clear() {
    state = const AsyncValue.data([]);
  }
}
