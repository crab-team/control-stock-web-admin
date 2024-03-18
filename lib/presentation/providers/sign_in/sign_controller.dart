import 'package:control_stock_web_admin/presentation/providers/sign_in/sign_providers.dart';
import 'package:control_stock_web_admin/providers/auth/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInController extends AutoDisposeAsyncNotifier<void> {
  @override
  build() {}

  Future<void> signInWithEmailLink(String email) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(signInWitEmailLinkUseCase).call(email);
      return response.fold((l) {
        setLoggedIn(false);
        throw l;
      }, (r) {
        setLoggedIn(true);
      });
    });
  }

  setLoggedIn(bool newState) {
    ref.read(authControllerProvider.notifier).set(newState);
  }
}
