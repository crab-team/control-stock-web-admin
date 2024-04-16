import 'package:dartz/dartz.dart';
import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/domain/repositories/auth_repository.dart';

class ExchangeToken {
  final AuthRepository _authRepository;

  ExchangeToken(this._authRepository);

  Future<Either<Failure, User>> execute(String token) async {
    return await _authRepository.exchangeToken(token);
  }
}
