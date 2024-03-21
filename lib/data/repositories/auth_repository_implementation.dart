import 'package:dartz/dartz.dart';
import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/responses/user_response.dart';
import 'package:control_stock_web_admin/domain/entities/sign_in_crendentials.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:control_stock_web_admin/domain/repositories/auth_repository.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final APIClient apiClient;

  AuthRepositoryImplementation(this.apiClient);

  @override
  Future<Either<Failure, void>> signInWithEmailLink(String email) async {
    try {
      const path = '/auth/admins/sign-in';
      await apiClient.sendPost(path, body: {'email': email});
      return const Right(null);
    } catch (e) {
      return Left(Failure('Ha ocurrido un error al enviar el correo de inicio de sesión. Inténtelo de nuevo.'));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithCredentials(SignInCredentials credentials) async {
    try {
      final response = await apiClient.sendPost('/auth/admins/sign-in', body: credentials.toJson());

      if (response.statusCode != 401) {
        return Left(UnauthorizedFailure());
      }

      if (response.statusCode != 200) {
        return Left(ServerFailure());
      }

      final userResponse = UserResponse.fromJson(response.data);
      final user = userResponse.toDomain();
      return Right(user);
    } catch (e) {
      return Left(Failure('Ha ocurrido un error al iniciar sesión. Inténtelo de nuevo.'));
    }
  }

  @override
  Future<Either<Failure, User>> exchangeToken(String token) async {
    try {
      String path = '/auth/admins/exchange';
      final response = await apiClient.sendPost(path, body: {'token': token});
      final userResponse = UserResponse.fromJson(response);
      final user = userResponse.toDomain();
      return Right(user);
    } catch (e) {
      return Left(e is Failure ? e : Failure('Ha ocurrido un error al intercambiar el token. Inténtelo de nuevo.'));
    }
  }
}
