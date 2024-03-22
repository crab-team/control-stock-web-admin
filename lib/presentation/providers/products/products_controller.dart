import 'dart:async';

import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsControllerProvider = AsyncNotifierProvider<ProductsController, List<Product>>(ProductsController.new);

class ProductsController extends AsyncNotifier<List<Product>> {
  List<Product> products = [];

  @override
  FutureOr<List<Product>> build() async {
    return await getAll();
  }

  getAll() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(getProductsUseCaseProvider).call();
      return productsEither.fold(
        (l) => throw l,
        (r) {
          List<Product> products = r;
          products.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          return products;
        },
      );
    });

    products = state.asData?.value ?? [];
    return products;
  }

  search(String query) async {
    if (query.isEmpty) {
      state = AsyncValue.data(products);
      return;
    }

    state = const AsyncValue.loading();
    state = AsyncValue.data(
      products.where((element) {
        final byName = element.name.toLowerCase().contains(query.toLowerCase());
        final byCategory = element.category.toLowerCase().contains(query.toLowerCase());

        return byName || byCategory;
      }).toList(),
    );
  }

  delete(String id) async {
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

    products = state.asData?.value ?? [];
    return products;
  }

  create(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(createProductUseCaseProvider).execute(product);
      return productsEither.fold(
        (l) => throw l,
        (r) {
          products.add(r);
          return products;
        },
      );
    });

    products = state.asData?.value ?? [];
    return products;
  }

  updateProduct(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(updateProductUseCaseProvider).execute(product);
      return productsEither.fold(
        (l) => throw l,
        (r) {
          final index = products.indexWhere((element) => element.id == product.id);
          products[index] = product;
          return products;
        },
      );
    });

    products = state.asData?.value ?? [];
    return products;
  }
}
