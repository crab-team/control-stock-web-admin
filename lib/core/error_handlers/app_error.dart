// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:control_stock_web_admin/core/error_handlers/error_code.dart';

class AppError {
  final ErrorCode code;
  final String? message;

  AppError({
    required this.code,
    this.message,
  });

  @override
  String toString() => 'AppError(code: $code, message: $message)';

  factory AppError.fromMap(Map<String, dynamic> map) {
    return AppError(
      code: fromString(map['code']),
      message: map['message'] ?? '',
    );
  }

  static ErrorCode fromString(String code) {
    return ErrorCode.values.firstWhere(
      (e) => e.toString() == 'ErrorCode.$code',
      orElse: () => ErrorCode.UNEXPECTED_ERROR,
    );
  }

  static AppError handle(dynamic error) {
    print('Error: $error');
    return AppError.fromMap(json.decode(error.toString()));
  }
}
