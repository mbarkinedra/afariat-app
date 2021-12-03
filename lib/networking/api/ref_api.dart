import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:afariat/networking/json/ref_json.dart';

abstract class RefApi extends ApiManager {
  @override
  AbstractJsonResource fromJson(data) {
    return RefListJson.fromJson(data);
  }
}

//Geoloc
class CityApi extends RefApi {
  @override
  String apiUrl() => SettingsApp.cityUrl;
}

class TownApi extends RefApi {
  @override
  String apiUrl() => SettingsApp.townUrl;
}

//Refs
class PriceApi extends RefApi {
  @override
  String apiUrl() => SettingsApp.priceUrl;
}
