import 'package:get/get.dart';

class ParameterBag {
  Map<String, dynamic> data = {};

  ParameterBag([this.data]);

  factory ParameterBag.from(ParameterBag p) => ParameterBag(p.data);

  //Observable count to make it accessible from views
  RxInt count = 0.obs;

  String toHttpQuery() =>
      Uri(
          queryParameters:
          data?.map((key, value) => MapEntry(key, value?.toString()))).query;

  set(k, v) {
    data ??= {};
    data[k] = v;
    count.value = data.length;
  }

  get(k) {
    if (data == null) {
      return null;
    }
    return data.containsKey(k) ? data[k] : null;
  }

  remove(k) {
    if (data[k] != null) {
      data.remove(k);
    }
    count.value = data.length;
  }

  clear() {
    data?.clear();
    count.value = 0;
  }

  clearExcept(k) {
    data?.removeWhere((key, value) => key == k);
    count.value = data?.length ?? 0;
  }

  has(k){
    return data == null ? false : data.containsKey(k);
  }
}

class Filter {
  static Rx<ParameterBag> rxParameters = ParameterBag().obs;

  static ParameterBag parameters() => rxParameters.value;

  static String toHttpQuery() => rxParameters.value.toHttpQuery();

  /// Set data to map searchData
  static set(k, v) => rxParameters.value.set(k, v);

  static get(k) => rxParameters.value.get(k);

  static has(k) => rxParameters.value.has(k);

  /// Delete data  from map searchData
  static remove(k) => rxParameters.value.remove(k);

  /// Clear the filter data
  static clear() => rxParameters.value.clear();

  ///Clear all except the given index param
  static clearExcept(k) => rxParameters.value.clearExcept(k);

  static int count() => rxParameters.value.count.value;
}
