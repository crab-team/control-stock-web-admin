import 'package:dartz/dartz.dart';
import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/repositories/auth_repository.dart';

class IsLoggedIn {
  final AuthRepository _authRepository;

  IsLoggedIn(this._authRepository);

  Future<Either<Failure, bool>> call() async {
    return await _authRepository.isLoggedIn();
  }
}
