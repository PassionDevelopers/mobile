import 'package:dio/dio.dart';
import '../../domain/repositoryInterfaces/token_storage_interface.dart';
import '../base_url.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorageRepository tokenStorageRepository;

  AuthInterceptor(this.tokenStorageRepository);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenStorageRepository.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

Dio createDio(TokenStorageRepository tokenStorageRepository) {
  final dio = Dio(
    BaseOptions(
      baseUrl: prod,
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