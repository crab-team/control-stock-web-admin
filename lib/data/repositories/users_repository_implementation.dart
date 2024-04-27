import 'package:fpdart/fpdart.dart';
import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/data_sources/users/users_local_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/domain/repositories/users_repository.dart';

class UsersRepositoryImplementation implements UsersRepository {
  final UsersLocalDataSource localDataSource;

  UsersRepositoryImplementation({
    required this.localDataSource,
  });

  @override
  Future<Either<AppError, User?>> getUser() async {
    return await localDataSource.getUser();
  }

  @override
  Future<Either<AppError, void>> storeUser(User user) async {
    return await localDataSource.storeUser(user);
  }
}
