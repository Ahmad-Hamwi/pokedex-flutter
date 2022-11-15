import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logPrint("----- Request ---->");
    logPrint(options.path.toString());
    logPrint("----- Query Params ---->");
    logPrint(
        const JsonEncoder.withIndent('  ').convert(options.queryParameters));
    logPrint("----- Headers -----");
    options.headers.forEach((key, value) => printKV(key, value.toString()));
    logPrint("----- Body -----");
    printAll(options.data ?? "");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logPrint("<---- Response -----");
    logPrint(response.requestOptions.path);
    logPrint("----- Status code -----");
    logPrint(response.statusCode.toString());
    logPrint("----- Headers -----");
    response.headers.forEach((key, value) => printKV(key, value));
    logPrint("----- Body -----");
    printAll(response.data ?? "");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      logPrint("<---- Response -----");
      logPrint(response.requestOptions.path);
      logPrint("----- Status code -----");
      logPrint(response.statusCode.toString());
      logPrint("----- Headers -----");
      response.headers.forEach((key, value) => printKV(key, value));
      logPrint("----- Body -----");
      printAll(response.data ?? "");
    }
    super.onError(err, handler);
  }

  void printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  void logPrint(String s) {
    log(s);
  }
}
