import 'package:fpdart/fpdart.dart';
import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/sign_in_crendentials.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/domain/repositories/auth_repository.dart';

class SignInWithCredentials {
  final AuthRepository _authRepository;

  SignInWithCredentials(this._authRepository);

  Future<Either<AppError, User>> execute(SignInCredentials credentials) async {
    return _authRepository.signInWithCredentials(credentials);
  }
}
