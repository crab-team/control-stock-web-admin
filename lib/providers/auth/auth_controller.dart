import 'package:control_stock_web_admin/domain/use_cases/auth/is_logged_in.dart';
import 'package:control_stock_web_admin/providers/repositories_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoggedInUseCaseProvider = Provider<IsLoggedIn>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return IsLoggedIn(authRepository);
});

final authControllerProvider = AsyncNotifierProvider<AuthController, bool>(AuthController.new);

class AuthController extends AsyncNotifier<bool> {
  @override
  build() async {
    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider).call();
    return isLoggedIn.fold((l) {
      return false;
    }, (r) {
      return r;
    });
  }

  void set(bool newState) {
    state = AsyncValue.data(newState);
  }
}
