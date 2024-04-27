import 'package:fpdart/fpdart.dart';
import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/sign_in_crendentials.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<AppError, void>> signInWithEmailLink(String email);
  Future<Either<AppError, User>> signInWithCredentials(SignInCredentials credentials);
  Future<Either<AppError, User>> exchangeToken(String token);
}
