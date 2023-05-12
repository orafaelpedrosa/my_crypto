import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpService {
  final Dio _dio = Dio();

  HttpService() {
    _dio.options.baseUrl = dotenv.get('URL_BASE');
    _dio.options.connectTimeout = 3000;
    _dio.interceptors.add(LogInterceptor(
      responseHeader: false,
      responseBody: true,
      error: false,
    ));
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }

  Future<Response> post(String url, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(url, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(String url, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    return await _dio.put(url, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return await _dio.delete(url, queryParameters: queryParameters);
  }
}
