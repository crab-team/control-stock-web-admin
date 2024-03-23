import 'dart:async';

import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:control_stock_web_admin/utils/csv_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadCsvProductsControllerProvider =
    AutoDisposeAsyncNotifierProvider<UploadCsvProductsController, List<Product>>(UploadCsvProductsController.new);

class UploadCsvProductsController extends AutoDisposeAsyncNotifier<List<Product>> {
  @override
  build() {
    return [];
  }

  upload(String category) async {
    state = const AsyncValue.loading();
    final csv = await CsvLoader.upload();
    List<Product> products = [];
    products = await Future.value(csv
        .map((e) => Product(
              code: e.code!,
              name: e.name!,
              category: category,
              price: e.price!,
              stock: e.stock!,
              imageUrl: '',
            ))
        .toList());
    state = AsyncValue.data(products);
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
        products[index] = product.copyWith(price: double.tryParse(value) ?? 0.0);
        break;
      case 'stock':
        products[index] = product.copyWith(stock: int.tryParse(value) ?? 0);
        break;
    }

    state = AsyncValue.data(products);
  }

  saveCsvProducts() async {
    final products = state.asData!.value;
    List<Product> productsNotSaved = [];
    state = const AsyncValue.loading();
    Future.wait(
      products.map((e) async {
        final response = await ref.read(createProductUseCaseProvider).execute(e);
        response.fold((l) => productsNotSaved.add(e), (r) {});
      }),
    ).whenComplete(() => state = AsyncValue.data(productsNotSaved));
  }

  clear() {
    state = const AsyncValue.data([]);
  }
}
