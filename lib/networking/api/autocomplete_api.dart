import 'package:afariat/networking/json/abstract_json_resource.dart';
import '../../config/settings_app.dart';
import '../json/localization_json.dart';
import 'api_manager.dart';

class LocalizationSearchApi extends ApiManager {
  String search;

  @override
  String apiUrl() => SettingsApp.autocompleteLocalization + "?search=" + search;

  @override
  AbstractJsonResource fromJson(data) {
    return LocalizationListJson.fromJson(data);
  }
}
