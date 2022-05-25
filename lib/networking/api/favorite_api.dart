import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/favorite_json.dart';

class FavoriteApi extends ApiManager {
  @override
  String apiUrl() {
    return SettingsApp.favorite;
  }

  @override
  fromJson(data) {
    return FavoriteJson.fromJson(data);
  }
}
