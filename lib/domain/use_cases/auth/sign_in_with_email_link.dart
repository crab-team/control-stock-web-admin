import 'package:dartz/dartz.dart';
import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/repositories/auth_repository.dart';

class SignInWitEmailLink {
  final AuthRepository _authRepository;

  SignInWitEmailLink(this._authRepository);

  Future<Either<Failure, void>> call(String email) async {
    return await _authRepository.signInWithEmailLink(email);
  }
}
