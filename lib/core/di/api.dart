import 'dart:developer';
import 'package:could_be/constants.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositoryInterfaces/token_storage_interface.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorageRepository tokenStorageRepository;
  AuthInterceptor(this.tokenStorageRepository);

  Future<String?> _refreshToken() async {
    final user = getIt<FirebaseAuth>().currentUser;
    if (user != null) {
      return await user.getIdToken(true);
    }
    return null;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenStorageRepository.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['accept'] = 'application/json';
    if(options.queryParameters.containsKey('lastIssueId') && options.queryParameters['lastIssueId'] == null) {
      options.queryParameters.remove('lastIssueId');
    }
    if(options.queryParameters.containsKey('lastArticleId') && options.queryParameters['lastArticleId'] == null) {
      options.queryParameters.remove('lastArticleId');
    }
    log('send Api Token: $token');
    log('Request URL: ${options.baseUrl}${options.path}');
    log('Request Method: ${options.method}');
    log('Request Headers: ${options.headers}');
    log('Request Data: ${options.data}');
    log('Request Query Parameters: ${options.queryParameters}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    log('Response Status Code: ${response.statusCode}');
    log('Response Data: ${response.data}');
    // log('Response Data: ${response.data['issues']['isSubscribed']}');
    log('Response Headers: ${response.headers}');
    log('Response Request Options: ${response.requestOptions.path}');
    log('Response Error: ${response.statusMessage}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log('Dio Error: ${err.message}');
    if (err.response?.statusCode == 401) {
      log('401 401 401 401 Unauthorized request, trying to refresh token...');
      final originalRequest = err.requestOptions;
      try {
        final newToken = await _refreshToken();
        log('New Token: $newToken');
        if (newToken != null) {
          await tokenStorageRepository.saveToken(newToken);
          final retryRequest = await getIt<Dio>().request(
            originalRequest.path,
            options: Options(
              method: originalRequest.method,
              headers: {
                ...originalRequest.headers,
                'Authorization': 'Bearer $newToken',
              },
            ),
            data: originalRequest.data,
            queryParameters: originalRequest.queryParameters,
          );
          return handler.resolve(retryRequest);
        }
      } catch (e) {
        log('Error refreshing token: $e');
        return handler.reject(err);
      }
    }
    return handler.next(err);
  }
}

Dio createDio(TokenStorageRepository tokenStorageRepository) {
  final dio = Dio(
    BaseOptions(
      baseUrl: EnvConstants.api,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );
  dio.interceptors.add(AuthInterceptor(tokenStorageRepository));
  return dio;
}

// final Dio dio = Dio(
//   BaseOptions(
//     baseUrl: prod,
//     connectTimeout: const Duration(seconds: 10),
//     receiveTimeout: const Duration(seconds: 10),
//     sendTimeout: const Duration(seconds: 10),
//     headers: {
//       'Authorization': 'Bearer ${UserPreferences.getIdToken() ?? ''}',
//     },
//   ),
// );