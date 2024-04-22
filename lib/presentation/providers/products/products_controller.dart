import 'dart:async';

import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/providers/toasts/toasts_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsControllerProvider = AsyncNotifierProvider<ProductsController, List<Product>>(ProductsController.new);

class ProductsController extends AsyncNotifier<List<Product>> {
  List<Product> products = [];

  @override
  FutureOr<List<Product>> build() async {
    if (products.isEmpty) {
      await getAll();
    }
    return products;
  }

  getAll() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(getProductsUseCaseProvider).call();
      return productsEither.fold((l) => throw l, (r) => products = r);
    });

    sortByName();
  }

  search(String query) async {
    if (query.isEmpty) {
      state = AsyncValue.data(products);
      return;
    }

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
    _showToast(ToastControllerModel(Texts.products, '${Texts.deletingProduct} $id', ToastType.info));
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(deleteProductUseCaseProvider).execute(id);
      return productsEither.fold(
        (l) {
          _showToast(ToastControllerModel(Texts.products, '${Texts.errorDeletingProduct} $id', ToastType.error));
          throw l;
        },
        (r) {
          _showToast(ToastControllerModel(Texts.products, '${Texts.productDeleted} $id', ToastType.success));
          products.removeWhere((element) => element.id == id);
          return products;
        },
      );
    });

    sortByName();
  }

  create(Product product) async {
    _showToast(ToastControllerModel(Texts.products, '${Texts.creatingProduct} ${product.code}', ToastType.info));
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(createProductUseCaseProvider).execute(product);
      return productsEither.fold((l) {
        _showToast(
            ToastControllerModel(Texts.products, '${Texts.errorCreatingProduct} ${product.code}', ToastType.error));
        throw l;
      }, (r) {
        products.add(r);
        _showToast(ToastControllerModel(Texts.products, '${Texts.productCreated} ${product.code}', ToastType.success));
        return products;
      });
    });

    sortByName();
  }

  createProducts(List<Product> products) async {
    _showToast(ToastControllerModel(Texts.products, Texts.creatingProducts, ToastType.loading));
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(createProductsUseCaseProvider).execute(products);
      return productsEither.fold((l) {
        _showToast(ToastControllerModel(Texts.products, Texts.errorCreatingProducts, ToastType.error));
        throw l;
      }, (r) async {
        _showToast(ToastControllerModel(Texts.products, Texts.allProductsUpdated, ToastType.success));
        return products;
      });
    });

    await getAll();
    sortByName();
  }

  updateProduct(Product product) async {
    _showToast(ToastControllerModel(Texts.products, '${Texts.updatingProduct} ${product.code}', ToastType.info));
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(updateProductUseCaseProvider).execute(product);
      return productsEither.fold((l) {
        _showToast(
            ToastControllerModel(Texts.products, '${Texts.errorUpdatingProduct} ${product.code}', ToastType.error));
        throw l;
      }, (r) {
        _showToast(ToastControllerModel(Texts.products, '${Texts.productUpdated} ${product.code}', ToastType.success));
        products.removeWhere((element) => element.id == product.id);
        products.add(r);
        return products;
      });
    });

    sortByName();
  }

  updateProducts(List<Product> products) async {
    _showToast(ToastControllerModel(Texts.products, Texts.updatingProducts, ToastType.loading));
    state = await AsyncValue.guard(() async {
      final productsEither = await ref.read(updateProductsUseCaseProvider).execute(products);
      return productsEither.fold((l) {
        _showToast(ToastControllerModel(Texts.products, Texts.errorUpdatingProducts, ToastType.error));
        throw l;
      }, (r) async {
        _showToast(ToastControllerModel(Texts.products, Texts.allProductsUpdated, ToastType.success));
        return products;
      });
    });

    await getAll();
    sortByName();
  }

  sortByName() {
    products.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    state = AsyncValue.data(products);
  }

  void _showToast(ToastControllerModel toastController) {
    ref.read(toastsControllerProvider.notifier).showToast(toastController);
  }
}
