import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class UsersLocalDataSource {
  Future<Either<AppError, void>> storeUser(User user);
  Future<Either<AppError, User?>> getUser();
}
