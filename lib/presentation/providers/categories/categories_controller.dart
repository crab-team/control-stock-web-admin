import 'dart:async';

import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesControllerProvider =
    AutoDisposeAsyncNotifierProvider<CategoriesController, List<Category>>(CategoriesController.new);

class CategoriesController extends AutoDisposeAsyncNotifier<List<Category>> {
  List<Category> categories = [];

  @override
  FutureOr<List<Category>> build() async {
    await getAll();
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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final categoriesEither = await ref.read(deleteCategoryUseCaseProvider).execute(id);
      return categoriesEither.fold(
        (l) => throw l,
        (r) {
          categories.removeWhere((element) => element.id == id);
          return categories;
        },
      );
    });
    sortByName();
  }

  create(String category, double percentageProfit) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final categoriesEither = await ref.read(createCategoryUseCaseProvider).execute(category, percentageProfit);
      return categoriesEither.fold(
        (l) => throw l,
        (r) {
          categories.add(r);
          return categories;
        },
      );
    });

    sortByName();
  }

  updateCategory(Category category) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final categoriesEither = await ref.read(updateCategoryUseCaseProvider).execute(category);
      return categoriesEither.fold(
        (l) => throw l,
        (r) {
          final index = categories.indexWhere((element) => element.id == category.id);
          categories[index] = category;
          return categories;
        },
      );
    });
    sortByName();
  }

  sortByName() {
    categories.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    state = AsyncValue.data(categories);
  }
}
