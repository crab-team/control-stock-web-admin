import 'package:control_stock_web_admin/domain/entities/sign_in_crendentials.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/presentation/providers/users/user_controller.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInControllerProvider = AsyncNotifierProvider.autoDispose<SignInController, void>(
  SignInController.new,
);

class SignInController extends AutoDisposeAsyncNotifier<void> {
  @override
  build() {}

  Future<void> signInWithEmailLink(String email) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(signInWitEmailLinkUseCase).call(email);
      response.mapLeft((l) {
        throw l.message!;
      });
    });
  }

  Future<void> signInWithCredentials(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response =
          await ref.read(signInWithCredentialsUseCase).execute(SignInCredentials(email: email, password: password));
      response.mapLeft((l) {
        throw l.message!;
      });
    });
  }
}

final exchangeTokenController = FutureProvider.autoDispose.family<User, String>((ref, token) async {
  final response = await ref.read(exchangeTokenUseCase).execute(token);
  return response.fold((l) {
    throw l.message!;
  }, (user) {
    ref.read(userControllerProvider.notifier).storeUser(user);
    return user;
  });
});
