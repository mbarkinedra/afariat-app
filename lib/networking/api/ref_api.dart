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

class VehicleBrands extends RefApi {
  @override
  String apiUrl() => SettingsApp.vehicleBrandsUrl;
}

class MotoBrandsApi extends RefApi {
  @override
  String apiUrl() => SettingsApp.motoBrandsUrl;
}

class MileagesApi extends RefApi {
  @override
  String apiUrl() => SettingsApp.mileagesUrl;
}

class YearsModelsApi extends RefApi {
  @override
  String apiUrl() => SettingsApp.yearsModelsUrl;
}

class RoomsNumberApi extends RefApi {
  @override
  String apiUrl() => SettingsApp.roomsNumberUrl;
}