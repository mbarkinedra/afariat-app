import 'package:get/get.dart';

class ParameterBag {
  Map<String, dynamic> data = {};

  //Observable count to make it accessible from views
  RxInt count = 0.obs;

  String toHttpQuery() => Uri(
      queryParameters:
          data.map((key, value) => MapEntry(key, value?.toString()))).query;

  set(k, v) {
    data[k] = v;
    count.value = data.length;
  }

  remove(k) {
    if (data[k] != null) {
      data.remove(k);
    }
    count.value = data.length;
  }

  clear() => data.clear();
}

class Filter {
  static Rx<ParameterBag> rxParameters = ParameterBag().obs;

  static ParameterBag parameters() => rxParameters.value;

  static String toHttpQuery() => rxParameters.value.toHttpQuery();

  /// Set data to map searchData
  static set(k, v) => rxParameters.value.set(k, v);

  /// Delete data  from map searchData
  static remove(k) => rxParameters.value.remove(k);

  /// Clear the filter data
  static clear() => rxParameters.value.clear();

  static int count() => rxParameters.value.count.value;
}
