import 'package:dartz/dartz.dart';
import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/sign_in_crendentials.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signInWithEmailLink(String email);
  Future<Either<Failure, User>> signInWithCredentials(SignInCredentials credentials);
  Future<Either<Failure, User>> exchangeToken(String token);
}
