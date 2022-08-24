import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String getParameter(String parameter) {
    if (dotenv.env.containsKey(parameter)) {
      return dotenv.env[parameter];
    }
    print('Error: Argument $parameter not found in env file');
    return null;
  }

  static String get baseUrl => getParameter('BASE_URL');

  static String get apikey => getParameter('APIKEY');

  static String get locale => getParameter('LOCALE');

  static String get currencySymbol => getParameter('CURRENCY_SYMBOL');
}
