import 'package:dartz/dartz.dart';
import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/data_sources/users_local_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/domain/repositories/users_repository.dart';

class UsersRepositoryImplementation implements UsersRepository {
  final UsersLocalDataSource localDataSource;

  UsersRepositoryImplementation({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User?>> getUser() async {
    try {
      final localUser = await localDataSource.getUser();
      return Right(localUser);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> storeUser(User user) async {
    try {
      await localDataSource.storeUser(user);
      return const Right(null);
    } on Exception {
      return Left(CacheFailure());
    }
  }
}
