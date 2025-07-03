import 'package:dio/dio.dart';
import '../base_url.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: dev,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
  ),
);