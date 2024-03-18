import 'package:control_stock_web_admin/domain/use_cases/auth/sign_in_with_email_link.dart';
import 'package:control_stock_web_admin/presentation/providers/sign_in/sign_controller.dart';
import 'package:control_stock_web_admin/providers/repositories_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Use cases
final signInWitEmailLinkUseCase = Provider<SignInWitEmailLinkUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return SignInWitEmailLinkUseCase(repository);
});

// Controllers
final signInControllerProvider = AsyncNotifierProvider.autoDispose<SignInController, void>(
  SignInController.new,
);
