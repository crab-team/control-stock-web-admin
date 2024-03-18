import 'package:dartz/dartz.dart';
import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/domain/repositories/auth_repository.dart';
import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImplementation implements AuthRepository {
  APIClient apiClient;

  AuthRepositoryImplementation(this.apiClient);

  @override
  Future<Either<Failure, void>> signInWithEmailLink(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // final response = await apiClient.sendPost(email);

      // if (response.statusCode != 200) {
      //   return Left(Failure('Error'));
      // }

      await Future.delayed(const Duration(seconds: 2));
      prefs.setString('token', email);

      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        return const Right(false);
      }

      return const Right(true);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
