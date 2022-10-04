import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';

class CategoriesGrouppedApi extends ApiManager {
  int categoryId;
  @override
  String apiUrl() {

    return SettingsApp.grouppedCategoriesUrl ;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return CategoriesGroupedJsonList.fromJson(data);
  }

  @override
  String baseApiUrl() {
    return SettingsApp.grouppedCategoriesUrl ;
  }
}
