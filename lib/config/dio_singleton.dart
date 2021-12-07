import 'package:dio/dio.dart';
import 'package:afariat/config/settings_app.dart';

class DioSingleton {
  Dio dio = Dio(BaseOptions(
      headers: {
        'apikey': SettingsApp.apiKey,
        'Content-Type': 'application/json; charset=UTF-8'
      }
      ));
  static final DioSingleton _singleton = DioSingleton._internal();

  factory DioSingleton() {
    return _singleton;
  }

  DioSingleton._internal();
}
