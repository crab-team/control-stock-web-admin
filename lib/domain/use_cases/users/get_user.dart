import 'package:fpdart/fpdart.dart';
import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/domain/repositories/users_repository.dart';

class GetUser {
  final UsersRepository _repository;

  GetUser(this._repository);

  Future<Either<AppError, User?>> execute() async {
    return await _repository.getUser();
  }
}
