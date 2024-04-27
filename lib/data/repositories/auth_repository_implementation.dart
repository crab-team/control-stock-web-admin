import 'package:fpdart/fpdart.dart';
import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/data/responses/user_response.dart';
import 'package:control_stock_web_admin/domain/entities/sign_in_crendentials.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/domain/repositories/auth_repository.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final APIClient apiClient;

  AuthRepositoryImplementation(this.apiClient);
  String path = '/auth';

  @override
  Future<Either<AppError, void>> signInWithEmailLink(String email) async {
    final response = await apiClient.sendPost('$path/sign-in', body: {'email': email});
    return response.fold(
      (l) => Left(l),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<AppError, User>> signInWithCredentials(SignInCredentials credentials) async {
    final response = await apiClient.sendPost('$path/sign-in', body: credentials.toJson());
    return response.fold(
      (l) => Left(l),
      (r) {
        final userResponse = UserResponse.fromJson(r);
        final user = userResponse.toDomain();
        return Right(user);
      },
    );
  }

  @override
  Future<Either<AppError, User>> exchangeToken(String token) async {
    final response = await apiClient.sendPost('$path/exchange', body: {'token': token});
    return response.fold(
      (l) => Left(l),
      (r) {
        final userResponse = UserResponse.fromJson(r);
        final user = userResponse.toDomain();
        return Right(user);
      },
    );
  }
}
