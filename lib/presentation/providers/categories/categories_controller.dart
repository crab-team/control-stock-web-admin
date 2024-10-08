import 'dart:async';

import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/toasts/toasts_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesControllerProvider =
    AsyncNotifierProvider<CategoriesController, List<Category>>(CategoriesController.new);

class CategoriesController extends AsyncNotifier<List<Category>> {
  List<Category> categories = [];

  @override
  FutureOr<List<Category>> build() async {
    if (categories.isEmpty) {
      await getAll();
    }
    return categories;
  }

  getAll() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final categoriesEither = await ref.read(getCategoriesUseCaseProvider).execute();
      return categoriesEither.fold(
        (l) => throw l,
        (r) => r,
      );
    });

    categories = state.asData?.value ?? [];
    sortByName();
    return categories;
  }

  search(String query) async {
    if (query.isEmpty) {
      state = AsyncValue.data(categories);
      return;
    }

    state = const AsyncValue.loading();
    state = AsyncValue.data(
      categories.where((element) {
        final byName = element.name.toLowerCase().contains(query.toLowerCase());

        return byName;
      }).toList(),
    );
  }

  delete(int id) async {
    _showToast(ToastControllerModel(Texts.categories, '${Texts.deletingCategory} $id', ToastType.info));
    state = await AsyncValue.guard(() async {
      final categoriesEither = await ref.read(deleteCategoryUseCaseProvider).execute(id);
      return categoriesEither.fold(
        (l) {
          _showToast(ToastControllerModel(Texts.categories, '${Texts.errorDeletingCategory} $id', ToastType.error));
          throw l;
        },
        (r) {
          _showToast(ToastControllerModel(Texts.categories, '${Texts.categoryDeleted} $id', ToastType.success));
          categories.removeWhere((element) => element.id == id);
          return categories;
        },
      );
    });
    sortByName();
  }

  create(String category, double percentageProfit, double extraCosts) async {
    _showToast(ToastControllerModel(Texts.categories, '${Texts.creatingCategory} $category', ToastType.info));
    state = await AsyncValue.guard(() async {
      final categoriesEither =
          await ref.read(createCategoryUseCaseProvider).execute(category, percentageProfit, extraCosts);
      return categoriesEither.fold(
        (l) {
          _showToast(
              ToastControllerModel(Texts.categories, '${Texts.errorCreatingCategory} $category', ToastType.error));
          throw l;
        },
        (r) {
          _showToast(ToastControllerModel(Texts.categories, '${Texts.categoryCreated} $category', ToastType.success));
          categories.add(r);
          return categories;
        },
      );
    });

    sortByName();
  }

  updateCategory(Category category) async {
    _showToast(ToastControllerModel(Texts.categories, '${Texts.updatingCategory} ${category.name}', ToastType.info));
    state = await AsyncValue.guard(() async {
      final categoriesEither = await ref.read(updateCategoryUseCaseProvider).execute(category);
      return categoriesEither.fold(
        (l) {
          _showToast(ToastControllerModel(
              Texts.categories, '${Texts.errorUpdatingCategory} ${category.name}', ToastType.error));
          throw l;
        },
        (r) {
          _showToast(
              ToastControllerModel(Texts.categories, '${Texts.categoryUpdated} ${category.name}', ToastType.success));
          final index = categories.indexWhere((element) => element.id == category.id);
          categories[index] = category;
          return categories;
        },
      );
    });
    _refreshProducts();
    sortByName();
  }

  applyAdjust(int categoryId, double percentage) async {
    _showToast(ToastControllerModel(Texts.categories, '${Texts.applyingAdjust} $categoryId', ToastType.info));
    await AsyncValue.guard(() async {
      final categoriesEither = await ref.read(applyAdjustCategoryUseCaseProvider)(categoryId, percentage);
      return categoriesEither.fold(
        (l) {
          _showToast(
              ToastControllerModel(Texts.categories, '${Texts.errorApplyingAdjust} $categoryId', ToastType.error));
          throw l;
        },
        (_) {
          _showToast(ToastControllerModel(Texts.categories, '${Texts.adjustApplied} $categoryId', ToastType.success));
        },
      );
    });
    _refreshProducts();
  }

  sortByName() {
    categories.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    state = AsyncValue.data(categories);
  }

  _refreshProducts() {
    ref.read(productsControllerProvider.notifier).getAll();
  }

  _showToast(ToastControllerModel toast) {
    ref.read(toastsControllerProvider.notifier).showToast(toast);
  }
}
