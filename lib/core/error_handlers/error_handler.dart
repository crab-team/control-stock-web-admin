import 'package:control_stock_web_admin/core/error_handlers/failure.dart';

class ErrorTypes {
  static const String unexpectedError = 'UNEXPECTED_ERROR';
  static const String emailAlreadyInUse = 'EMAIL_ALREADY_IN_USE';
  static const String unauthorized = 'UNAUTHORIZED';
  static const String invalidCredentials = 'INVALID_CREDENTIALS';
  static const String userNotFound = 'USER_NOT_FOUND';
  static const String userDisabled = 'USER_DISABLED';
}

class ErrorHandler {
  static Failure handle(String code) {
    switch (code) {
      case ErrorTypes.unexpectedError:
        return UnexpectedFailure();
      case ErrorTypes.emailAlreadyInUse:
        return EmailAlreadyInUseFailure();
      case ErrorTypes.unauthorized:
        return UnauthorizedFailure();
      case ErrorTypes.invalidCredentials:
        return InvalidCredentialsFailure();
      case ErrorTypes.userNotFound:
        return UserNotFoundFailure();
      case ErrorTypes.userDisabled:
        return UserDisabledFailure();
      default:
        return UnexpectedFailure();
    }
  }
}
