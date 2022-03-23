//TODO: should not be in config folder
class Filter {
  static Map<String, dynamic> data = {};

  static String toHttpQuery() => Uri(
      queryParameters:
          data.map((key, value) => MapEntry(key, value?.toString()))).query;
}
