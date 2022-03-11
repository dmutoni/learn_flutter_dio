import 'dart:developer';

import 'package:dio/dio.dart';

import 'model/user.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = 'https://findapart.herokuapp.com/api/v1';

  Future<User?> getUser({required String id}) async {
    User? user;
    log(_baseUrl + id);
    try {
      Response userData = await _dio.get(_baseUrl + '/users/$id');
      user = User.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        log('Dio error!');
        log('Request: ${e.requestOptions.uri}');
        log('STATUS: ${e.response?.statusCode}');
        log('DATA: ${e.response?.data}');
        log('HEADERS: ${e.response?.headers}');
        log('MESSAGE: ${_baseUrl + 'users/$id'}');
      } else {
        // Error due to setting up or sending the request
        log('Error sending request!');
        log(e.message);
      }
    }
    return user;
  }
}
