import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/favorite_json.dart';

class DeleteFavoriteByAdvert  extends ApiManager {


  String IdAdvert;

  @override
  String apiUrl() {
    return SettingsApp.deleteFavoriteByAdvert + "/" + IdAdvert;
  }

  @override
  fromJson(data) {
    return FavoriteJson.fromJson(data);
  }

}