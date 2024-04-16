import 'package:dartz/dartz.dart';
import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/sign_in_crendentials.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/domain/repositories/auth_repository.dart';

class SignInWithCredentials {
  final AuthRepository _authRepository;

  SignInWithCredentials(this._authRepository);

  Future<Either<Failure, User>> execute(SignInCredentials credentials) async {
    return _authRepository.signInWithCredentials(credentials);
  }
}
