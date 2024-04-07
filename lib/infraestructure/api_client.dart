import 'dart:io';

import 'package:dio/dio.dart';
import 'package:control_stock_web_admin/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIClient {
  late final Dio dio;

  final String baseUrl;

  APIClient({required this.baseUrl}) {
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
    // dio.interceptors.add(LogInterceptor(responseBody: true));
    // dio.interceptors.add(InterceptorsWrapper(onError: (DioException error, handler) async {
    //   if (error.response?.statusCode == 401) {
    //     if (!error.requestOptions.path.contains('refresh-token')) {
    //       await _refreshToken();
    //       await _retry(error.requestOptions);
    //     }
    //   }
    //   return handler.next(error);
    // }));
  }

  Future<dynamic> sendGet(
    String path, {
    bool authenticated = false,
    Map<String, String> headers = const {},
    Map<String, String> queryParams = const {},
  }) async {
    if (authenticated) {
      headers = await _addAuthHeader(headers);
    }

    logger.d('-- GET: $path');

    return execute(
      () => dio.get(
        path,
        queryParameters: queryParams,
        options: Options(headers: headers),
      ),
    );
  }

  Future<dynamic> sendPost(
    String path, {
    bool authenticated = false,
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
    String? contentType = Headers.jsonContentType,
  }) async {
    if (authenticated) {
      headers = await _addAuthHeader(headers);
    }

    logger.d('-- POST: $path');
    logger.d('-- BODY: $body');

    return execute(
      () => dio.post(
        path,
        data: body,
        options: Options(headers: headers, contentType: contentType),
      ),
    );
  }

  Future<dynamic> sendDelete(
    String path, {
    bool authenticated = false,
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    if (authenticated) {
      headers = await _addAuthHeader(headers);
    }

    logger.d('-- DELETE: $path');
    logger.d('-- BODY: $body');

    return execute(
      () => dio.delete(
        path,
        data: body,
        options: Options(headers: headers),
      ),
    );
  }

  Future<dynamic> sendPut(
    String path, {
    bool authenticated = false,
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    if (authenticated) {
      headers = await _addAuthHeader(headers);
    }

    logger.d('-- PUT: $path');
    logger.d('-- BODY: $body');

    return execute(
      () => dio.put(
        path,
        data: body,
        options: Options(headers: headers),
      ),
    );
  }

  Future<dynamic> sendPatch(
    String path, {
    bool authenticated = false,
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
  }) async {
    if (authenticated) {
      headers = await _addAuthHeader(headers);
    }

    logger.d('-- PATCH: $path');
    logger.d('-- BODY: $body');

    return execute(
      () => dio.patch(
        path,
        data: body,
        options: Options(headers: headers),
      ),
    );
  }

  Future<dynamic> execute(Function() function) async {
    try {
      var response = await function();

      if (!_isResponseOk(response)) {
        throw Exception('Error: ${response.statusCode}');
      }

      return response.data;
    } on SocketException {
      throw Exception('No Internet connection');
    } on DioException catch (e) {
      logger.d('-- DIO ERROR: ${e.response}');
      throw Exception('Error: ${e.message}');
    }
  }

  bool _isResponseOk(Response response) {
    if (response.statusCode == null) return false;
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }

  Future<Map<String, String>> _addAuthHeader(Map<String, String> headers) async {
    String accessToken = await _getAccessToken();
    return {
      ...headers,
      HttpHeaders.authorizationHeader: accessToken,
    };
  }

  Future<String> _getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('accessToken');

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token not found');
    }

    return accessToken;
  }

  Future<String> _getRefreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final refreshToken = sharedPreferences.getString('refreshToken');

    logger.d('Refresh token: $refreshToken');

    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('Refresh token not found');
    }

    return refreshToken;
  }

  Future<dynamic> _retry(RequestOptions requestOptions) async {
    if (requestOptions.method == 'GET') {
      return sendGet(
        requestOptions.path,
        authenticated: true,
        headers: requestOptions.headers as Map<String, String>,
        queryParams: requestOptions.queryParameters as Map<String, String>,
      );
    }

    if (requestOptions.method == 'POST') {
      return sendPost(
        requestOptions.path,
        authenticated: true,
        body: requestOptions.data,
        headers: requestOptions.headers as Map<String, String>,
      );
    }

    throw Exception('Invalid request method');
  }

  Future<dynamic> _refreshToken() async {
    String refreshToken = await _getRefreshToken();

    return sendPost('/auth/refresh-token', body: {
      'refreshToken': refreshToken,
    });
  }
}
