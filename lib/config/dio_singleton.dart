import 'package:dio/dio.dart';
import 'package:afariat/config/settings_app.dart';

import 'Environment.dart';

class DioSingleton {
  Dio dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000 // 60 seconds
      ,
      headers: {
        'apikey': Environment.apikey,
        'Content-Type': 'application/json'
      }));

  static final DioSingleton _singleton = DioSingleton._internal();

  factory DioSingleton() {
    return _singleton;
  }

  DioSingleton._internal();
}
