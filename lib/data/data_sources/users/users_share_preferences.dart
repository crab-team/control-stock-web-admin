import 'dart:convert';

import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/core/error_handlers/error_code.dart';
import 'package:control_stock_web_admin/data/data_sources/users/users_local_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersSharePreferences implements UsersLocalDataSource {
  @override
  Future<Either<AppError, User?>> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final store = prefs.getString('user');
      if (store != null) {
        return Right(User.fromJson(json.decode(store)));
      }

      return const Right(null);
    } catch (e) {
      throw Left(AppError.handle(ErrorCode.CACHE_ERROR));
    }
  }

  @override
  Future<Either<AppError, void>> storeUser(User user) async {
    try {
      final prefs = SharedPreferences.getInstance();
      await prefs.then((value) => value.setString('user', json.encode(user.toJson())));
      return const Right(null);
    } catch (e) {
      throw Left(AppError.handle(ErrorCode.CACHE_ERROR));
    }
  }
}
