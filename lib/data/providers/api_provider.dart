import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart' as Getv;
import 'package:kemerahrfrontend/core/constant/constant.dart';

class ApiProvider {
  late final Dio _dio;
  final GetStorage _box = GetStorage();
  bool _isLoggingOut = false;

  ApiProvider() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstant.BaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
        validateStatus: (status) {
          // Accept all responses below 500
          return status != null && status < 500;
        },
      ),
    );

    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    // 🔐 Attach token automatically
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _box.read('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Content-Type'] = 'application/json';
          handler.next(options);
        },

        onError: (error, handler) async {
          final statusCode = error.response?.statusCode;

          // 🔥 Auto logout if unauthorized
          if (!_isLoggingOut && (statusCode == 401 || statusCode == 403)) {
            _isLoggingOut = true;

            await _box.remove('token');
            await _box.remove('roleid');

            Getv.Get.offAllNamed('/login');
          }

          handler.next(error);
        },
      ),
    );

    // 🐛 Logging only in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  // --------------------------
  // 🔹 HTTP METHODS
  // --------------------------

  Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(
        _normalizeEndpoint(endpoint),
        queryParameters: query,
      );

      _checkForServerError(response);
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(
        _normalizeEndpoint(endpoint),
        data: data,
      );

      _checkForServerError(response);
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<Response> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(_normalizeEndpoint(endpoint), data: data);

      _checkForServerError(response);
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<Response> delete(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.delete(
        _normalizeEndpoint(endpoint),
        data: data,
      );

      _checkForServerError(response);
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // --------------------------
  // 🔹 Helpers
  // --------------------------

  String _normalizeEndpoint(String endpoint) {
    return endpoint.startsWith('/') ? endpoint : '/$endpoint';
  }

  void _checkForServerError(Response response) {
    if (response.statusCode != null && response.statusCode! >= 500) {
      throw Exception("Server error. Please try again later.");
    }
  }

  Exception _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return Exception("Connection timeout. Please check internet.");
    }

    if (e.type == DioExceptionType.receiveTimeout) {
      return Exception("Server took too long to respond.");
    }

    if (e.type == DioExceptionType.badResponse) {
      return Exception(e.response?.data["message"] ?? "Something went wrong.");
    }

    return Exception("Unexpected network error.");
  }
}
