import 'package:dio/dio.dart';

class JsonPlaceholderCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  JsonPlaceholderCustomDio() {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com";
  }
}
