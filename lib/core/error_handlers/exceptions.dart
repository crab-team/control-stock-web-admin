import 'package:control_stock_web_admin/core/error_handlers/error_code.dart';

class BadRequestException implements Exception {
  final ErrorCode code;

  BadRequestException(this.code);

  @override
  String toString() => 'BadRequestException: $code';
}

class NotFoundException implements Exception {
  @override
  String toString() => 'NotFoundException';
}

class ServerErrorException implements Exception {
  @override
  String toString() => 'ServerErrorException';
}

class UnauthorizedException implements Exception {
  @override
  String toString() => 'UnauthorizedException';
}

class NoInternetConnectionException implements Exception {
  @override
  String toString() => 'NoInternetConnectionException';
}

class UnexpectedErrorException implements Exception {
  UnexpectedErrorException();

  @override
  String toString() => 'UnexpectedErrorException';
}
