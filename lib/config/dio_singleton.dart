import 'package:dio/dio.dart';

class DioSingleton {
  String name;
  Dio  dio =Dio();
  static final DioSingleton _singleton = DioSingleton._internal();

  factory DioSingleton() {
    return _singleton;

  }

  DioSingleton._internal();


}