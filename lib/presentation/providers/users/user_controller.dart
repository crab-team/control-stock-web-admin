import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userControllerProvider = AsyncNotifierProvider<UserController, User?>(UserController.new);

class UserController extends AsyncNotifier<User?> {
  @override
  build() async {
    final response = await ref.read(getUserUseCase).execute();
    return response.fold((l) {
      return null;
    }, (user) {
      return user;
    });
  }

  void storeUser(User user) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(storeUserUseCase).execute(user);
      response.leftMap((l) {
        throw l.message;
      });
      return user;
    });
  }
}
