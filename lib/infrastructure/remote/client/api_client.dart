import 'package:dio/dio.dart';

abstract class IApiClient {
  Future<Response> post(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      Object? body});

  Future<Response> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  });

  Future<Response> postMultipart(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    required Map<String, dynamic> formData,
  });
}
