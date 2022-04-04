import 'package:get/get.dart';

class FilterController extends GetxController {
  /// All data search
  Map<String, dynamic> searchData = {};

  /// Set data to map searchData
  setDataFilter({key, val}) {
    searchData[key] = val;
  }

  /// Delete data  from map searchData
  deleteDataFilter({key}) {
    if (searchData[key] != null) {
      searchData.remove(key);
    }
  }
}
