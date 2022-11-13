import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedex/infrastructure/remote/exception/exception_factory.dart';

import 'api_client.dart';

class DioApiClient implements IApiClient {
  final Dio _dioClient;
  final IRemoteExceptionFactory _exceptionFactory;

  DioApiClient(this._dioClient, this._exceptionFactory);

  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) {
    return _dioClient
        .get(
          url,
          options: Options(
            headers:
                headers ?? {HttpHeaders.contentTypeHeader: "application/json"},
          ),
          queryParameters: params,
        )
        .onError(mapError);
  }

  @override
  Future<Response> post(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    dynamic body,
  }) {
    return _dioClient
        .post(
          url,
          options: Options(
            headers:
                headers ?? {HttpHeaders.contentTypeHeader: "application/json"},
          ),
          queryParameters: params,
          data: body,
        )
        .onError(mapError);
  }

  @override
  Future<Response> postMultipart(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      required Map<String, dynamic> formData}) {
    return _dioClient
        .post(
          url,
          options: Options(headers: headers),
          queryParameters: params,
          data: FormData.fromMap(formData),
        )
        .onError(mapError);
  }

  @visibleForTesting
  Future<Response> mapError(error, stackTrace) async {
    if (error is! DioError) {
      return Future.error(error);
    }

    final response = error.response;

    if (response == null) {
      return Future.error(error);
    }

    Exception exceptionFromResponse =
        _exceptionFactory.create(response.statusCode!);

    return Future.error(exceptionFromResponse);
  }
}
