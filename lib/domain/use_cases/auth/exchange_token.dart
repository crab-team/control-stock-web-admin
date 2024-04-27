import 'package:fpdart/fpdart.dart';
import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/domain/repositories/auth_repository.dart';

class ExchangeToken {
  final AuthRepository _authRepository;

  ExchangeToken(this._authRepository);

  Future<Either<AppError, User>> execute(String token) async {
    return await _authRepository.exchangeToken(token);
  }
}
