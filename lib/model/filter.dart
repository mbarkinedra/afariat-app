class ParameterBag {
  Map<String, dynamic> data = {};

  String toHttpQuery() => Uri(
      queryParameters:
          data.map((key, value) => MapEntry(key, value?.toString()))).query;

  set(k, v) => data[k] = v;

  remove(k) {
    if (data[k] != null) {
      data.remove(k);
    }
  }

  clear() => data.clear();
}

class Filter {
  static ParameterBag parameters = ParameterBag();

  static String toHttpQuery() => parameters.toHttpQuery();

  /// Set data to map searchData
  static set(k, v) => parameters.set(k, v);

  /// Delete data  from map searchData
  static remove(k) => parameters.remove(k);

  /// Clear the filter data
  static clear() => parameters.clear();
}
