import 'dart:convert';

import 'package:control_stock_web_admin/core/error_handlers/failure.dart';
import 'package:control_stock_web_admin/data/data_sources/users/users_local_data_source.dart';
import 'package:control_stock_web_admin/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersSharePreferences implements UsersLocalDataSource {
  @override
  Future<User?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final store = prefs.getString('user');
      if (store != null) {
        return User.fromJson(json.decode(store));
      }

      return null;
    } catch (e) {
      throw CacheFailure();
    }
  }

  @override
  Future<void> storeUser(User user) {
    try {
      final prefs = SharedPreferences.getInstance();
      return prefs.then((value) => value.setString('user', json.encode(user.toJson())));
    } catch (e) {
      throw CacheFailure();
    }
  }
}
