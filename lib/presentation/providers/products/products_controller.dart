import 'dart:async';

import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsControllerProvider =
    AutoDisposeAsyncNotifierProvider<ProductsController, List<Product>>(ProductsController.new);

class ProductsController extends AutoDisposeAsyncNotifier<List<Product>> {
  List<Product> products = [];

  @override
  FutureOr<List<Product>> build() async {
    await getAll();
    return products;
  }

  getAll() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(getProductsUseCaseProvider).call();
      return productsEither.fold((l) => throw l, (r) => r);
    });

    products = state.asData?.value ?? [];
    sortByName();
  }

  search(String query) async {
    if (query.isEmpty) {
      state = AsyncValue.data(products);
      return;
    }

    state = const AsyncValue.loading();
    state = AsyncValue.data(
      products.where((element) {
        final byCode = element.code.toLowerCase().contains(query.toLowerCase());
        final byName = element.name.toLowerCase().contains(query.toLowerCase());
        final byCategory = element.category.name.toLowerCase().contains(query.toLowerCase());

        return byCode || byName || byCategory;
      }).toList(),
    );
  }

  delete(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(deleteProductUseCaseProvider).execute(id);
      return productsEither.fold(
        (l) => throw l,
        (r) {
          products.removeWhere((element) => element.id == id);
          return products;
        },
      );
    });

    sortByName();
  }

  create(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(createProductUseCaseProvider).execute(product);
      return productsEither.fold((l) => throw l, (r) {
        products.add(r);
        return products;
      });
    });

    sortByName();
  }

  createProducts(List<Product> products) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(createProductsUseCaseProvider).execute(products);
      return productsEither.fold((l) => throw l, (r) async {
        await getAll();
        return products;
      });
    });

    sortByName();
  }

  updateProduct(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(updateProductUseCaseProvider).execute(product);
      return productsEither.fold((l) => throw l, (r) {
        products.removeWhere((element) => element.id == product.id);
        products.add(r);
        return products;
      });
    });

    sortByName();
  }

  updateProducts(List<Product> products) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(updateProductsUseCaseProvider).execute(products);
      return productsEither.fold((l) => throw l, (r) async {
        await getAll();
        return products;
      });
    });

    sortByName();
  }

  updateCashPaymentPercentage(double value) {}

  sortByName() {
    products.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    state = AsyncValue.data(products);
  }
}
