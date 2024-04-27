import 'package:fpdart/fpdart.dart';
import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/repositories/auth_repository.dart';

class SignInWitEmailLink {
  final AuthRepository _authRepository;

  SignInWitEmailLink(this._authRepository);

  Future<Either<AppError, void>> call(String email) async {
    return await _authRepository.signInWithEmailLink(email);
  }
}
