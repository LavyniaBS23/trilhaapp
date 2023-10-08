import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:trilhaapp/repositories/back4app/back4app_dio_interceptor.dart';

class Back4AppCustomDio {
  final _dio = Dio();
  var _env = DotEnv();

  Dio get dio => _dio;

  Back4AppCustomDio() {
    _env = DotEnv();
     _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = _env['BACK4APPBASEURL']!;

    _dio.interceptors.add(Back4AppDioInterceptor());
  }
}
