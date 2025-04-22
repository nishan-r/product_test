import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';


class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  late final Dio _dio;

  NetworkService._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response?> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  void _handleError(DioException error) {
    if (error.response != null) {
      log(' API Error: ${error.response?.statusCode} ${error.response?.data}');
    } else {
      log('Network Error: ${error.message}');
    }
  }
}
