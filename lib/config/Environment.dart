import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String getParameter(String parameter) {
    if (dotenv.env.containsKey(parameter)) {
      return dotenv.env[parameter];
    }
    if (kDebugMode) {
      print('Error: Argument $parameter not found in env file');
    }
    return null;
  }

  static String get baseUrl => getParameter('BASE_URL');

  static String get apikey => getParameter('APIKEY');

  static String get locale => getParameter('LOCALE');

  static String get currencySymbol => getParameter('CURRENCY_SYMBOL');

  static String get helpUrl => getParameter('HELP_URL');

  static String get rulesUrl => getParameter('RULES_URL');

  static String get privacyUrl => getParameter('PRIVACY_URL');

  static String get cguUrl => getParameter('CGU_URL');

  static String get cityLabel => getParameter('CITY_LABEL');
  static String get townLabel => getParameter('TOWN_LABEL');

  static String get phonePlaceholder => getParameter('PHONE_PLACEHOLDER');

  static String get allCountryLabel => getParameter('ALL_COUNTRY_LABEL');

  static String get localizationSearchHint => getParameter('LOCALIZATION_SEARCH_HINT');
}
