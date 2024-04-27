import 'dart:io';

import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/core/error_handlers/error_code.dart';
import 'package:control_stock_web_admin/core/error_handlers/exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';

class APIClient {
  late final Dio dio;

  final String baseUrl;

  APIClient({
    required this.baseUrl,
    // required this.settingsRepository,
  }) {
    dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    dio.options.responseType = ResponseType.json;
    dio.options.headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.accessControlAllowOriginHeader: '*',
    };
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // dio.interceptors.add(_createRetryInterceptor());
  }

  Future<Either<AppError, dynamic>> sendGet(
    String path, {
    Map<String, String> headers = const {},
    Map<String, String> queryParams = const {},
  }) async {
    try {
      final result = await execute(
        () => dio.get(
          path,
          queryParameters: queryParams,
          options: Options(headers: headers),
        ),
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(_handleAppError(e));
    }
  }

  Future<Either<AppError, dynamic>> sendPost(
    String path, {
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
    String? contentType = Headers.jsonContentType,
  }) async {
    try {
      final result = await execute(
        () => dio.post(
          path,
          data: body,
          options: Options(headers: headers, contentType: contentType),
        ),
      );

      return Right(result);
    } on Exception catch (e) {
      return Left(_handleAppError(e));
    }
  }

  Future<Either<AppError, dynamic>> sendDelete(
    String path, {
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    try {
      final result = await execute(
        () => dio.delete(
          path,
          data: body,
          options: Options(headers: headers),
        ),
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(_handleAppError(e));
    }
  }

  Future<Either<AppError, dynamic>> sendPut(
    String path, {
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    try {
      final result = await execute(
        () => dio.put(
          path,
          data: body,
          options: Options(headers: headers),
        ),
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(_handleAppError(e));
    }
  }

  Future<Either<AppError, dynamic>> sendPatch(
    String path, {
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    try {
      final result = await execute(
        () => dio.patch(
          path,
          data: body,
          options: Options(headers: headers),
        ),
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(_handleAppError(e));
    }
  }

  Future<dynamic> execute(Function() function) async {
    try {
      Response response = await function();

      if (!_isResponseOk(response)) {
        throw _handleResponseException(response);
      }

      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError || e is SocketException) {
        throw NoInternetConnectionException();
      }
      throw _handleResponseException(e.response!);
    }
  }

  bool _isResponseOk(Response response) {
    if (response.statusCode == null) return false;
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }

  // Future<String> _getAccessToken() async {
  //   final userCredentials = await settingsRepository.getUserCredentials();
  //   if (userCredentials == null) return '';
  //   return userCredentials.getAccessToken();
  // }

  // Future<String> _refreshToken() async {
  //   final userCredentials = await settingsRepository.getUserCredentials();
  //   if (userCredentials == null) return '';

  //   final refreshToken = userCredentials.getRefreshToken();
  //   final newAccessTokenResponse = await sendPost('/accounts/refresh-token', body: {
  //     'refreshToken': refreshToken,
  //   });

  //   final newAccessTokenRight = newAccessTokenResponse.getRight() as Map<String, dynamic>;
  //   final newAccessToken = newAccessTokenRight['accessToken'];
  //   await settingsRepository.updateAccessToken(newAccessToken);
  //   return newAccessToken;
  // }

  // InterceptorsWrapper _createRetryInterceptor() {
  //   return InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //       String accessToken = await _getAccessToken();
  //       options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
  //       return handler.next(options);
  //     },
  //     onError: (DioException error, handler) async {
  //       if (error.response?.statusCode == 401) {
  //         try {
  //           String newAccessToken = await _refreshToken();
  //           error.requestOptions.headers[HttpHeaders.authorizationHeader] = 'Bearer $newAccessToken';
  //           return handler.resolve(await dio.fetch(error.requestOptions));
  //         } catch (e) {
  //           return handler.reject(error);
  //         }
  //       }

  //       return handler.next(error);
  //     },
  //   );
  // }

  Exception _handleResponseException(Response response) {
    switch (response.statusCode) {
      case 400:
        final codeAsString = response.data['code'];
        final code = AppError.fromString(codeAsString);
        return BadRequestException(code);
      case 401:
      case 403:
        return UnauthorizedException();
      case 404:
        return NotFoundException();
      case 500:
        return ServerErrorException();
      default:
        return UnexpectedErrorException();
    }
  }

  AppError _handleAppError(Exception e) {
    switch (e.runtimeType) {
      case BadRequestException:
        final exception = e as BadRequestException;
        final code = exception.code;
        return AppError(code: code);
      case UnauthorizedException:
      // return UnauthorizedError();
      case NotFoundException:
      // return NotFoundError();
      case ServerErrorException:
      // return ServerError();
      case NoInternetConnectionException:
      // return NoInternetConnectionError();
      default:
        return AppError(code: ErrorCode.UNEXPECTED_ERROR, message: 'Unexpected error');
    }
  }
}
