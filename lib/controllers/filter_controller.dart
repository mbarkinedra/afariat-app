
class FilterController   {
  /// All data search
static  Map<String, dynamic> searchData = {};

  /// Set data to map searchData
  static setDataFilter({key, val}) {
    searchData[key] = val;
  }

  /// Delete data  from map searchData
 static deleteDataFilter({key}) {
    if (searchData[key] != null) {
      searchData.remove(key);
    }
  }
}
