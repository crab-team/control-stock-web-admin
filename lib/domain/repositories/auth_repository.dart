import 'package:dartz/dartz.dart';
import 'package:control_stock_web_admin/core/error_handlers/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signInWithEmailLink(String email);
  Future<Either<Failure, bool>> isLoggedIn();
}
