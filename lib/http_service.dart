import 'dart:developer';

import 'package:dio/dio.dart';

class HttpService {
  late Dio _dio;
  final String baseUrl = "http://www.regres.in/";
  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
    initializeInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    late Response response;

    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      log(e.toString());
      throw Exception(e.message);
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors
        .add(InterceptorsWrapper(onError: (error, errorInterceptorHandler) {
      log(error.message);
    }, onRequest: (request, requestInterceptorHandler) {
      log("${request.method} | ${request.path}");
    }, onResponse: (response, responseInterceptorHandler) {
      log('${response.statusCode} ${response.statusCode} ${response.data}');
    }));
  }
}
