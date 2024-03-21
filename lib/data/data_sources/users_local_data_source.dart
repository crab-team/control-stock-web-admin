import 'package:control_stock_web_admin/domain/entities/user.dart';

abstract class UsersLocalDataSource {
  Future<void> storeUser(User user);
  Future<User?> getUser();
}
