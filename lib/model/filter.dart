class ParameterBag {
  Map<String, dynamic> data = {};

  String toHttpQuery() => Uri(
      queryParameters:
          data.map((key, value) => MapEntry(key, value?.toString()))).query;
}

//class Filter extends ParameterBag {}

class Filter {
  //TODO: make it as dynamic and inherits from ParameterBag
  static Map<String, dynamic> data = {};

  static String toHttpQuery() => Uri(
      queryParameters:
      data.map((key, value) => MapEntry(key, value?.toString()))).query;
}
