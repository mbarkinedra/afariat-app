import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:afariat/networking/json/categories_groupped_json.dart';

class GetCategoriesGrouppedApi extends ApiManager {
  @override
  String apiUrl() {
    return SettingsApp.grouppedCategoriesUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    CategoriesGrouppedJson.fromJson(data);
  }
}
