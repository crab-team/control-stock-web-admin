import 'package:dartz/dartz.dart';
import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/domain/repositories/users_repository.dart';

class StoreUser {
  final UsersRepository _repository;

  StoreUser(this._repository);

  Future<Either<Failure, void>> execute(User user) async {
    return await _repository.storeUser(user);
  }
}
