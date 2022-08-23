import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get baseUrl => dotenv.env['BASE_URL'];
  static String get apikey => dotenv.env['APIKEY'];
  static String get locale => dotenv.env['LOCALE'];
  static String get currencySymbol => dotenv.env['CURRENCY_SYMBOL'];
}