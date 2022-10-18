import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:dio/dio.dart';

import '../json/get_json_response.dart';

abstract class RefApi extends ApiManager {
  @override
  AbstractJsonResource fromJson(data) {
    return RefListJson.fromJson(data);
  }

  Future<GetJsonResponse> getJsonResponse() async {
    Response res = await getCollection(baseApiUrl(), toJson: false);
    return GetJsonResponse.fromJson(res.data);
  }
}

//Geoloc
class CityApi extends RefApi {
  @override
  @deprecated
  String apiUrl() => SettingsApp.cityUrl;

  String baseApiUrl() => SettingsApp.cityUrl;
}

class TownApi extends RefApi {
  String cityId;

  @override
  @deprecated
  String apiUrl() => SettingsApp.townUrl + "/" + cityId;

  @override
  String baseApiUrl() => SettingsApp.townUrl;
}

//Refs
class PriceApi extends RefApi {
  @override
  @deprecated
  String apiUrl() => SettingsApp.priceUrl;

  @override
  String baseApiUrl() => SettingsApp.priceUrl;
}

class VehicleBrandsApi extends RefApi {
  @override
  @deprecated
  String apiUrl() => SettingsApp.vehicleBrandsUrl;

  @override
  String baseApiUrl() => SettingsApp.vehicleBrandsUrl;
}

class RoomsNumberApi extends RefApi {
  @override
  @deprecated
  String apiUrl() => SettingsApp.roomsNumberUrl;

  @override
  String baseApiUrl() => SettingsApp.roomsNumberUrl;
}

class EnergieApi extends RefApi {
  @override
  @deprecated
  String apiUrl() => SettingsApp.energiesUrl;

  @override
  @deprecated
  String baseApiUrl() => SettingsApp.energiesUrl;
}

class VehicleModelApi extends RefApi {
  int vehicleModelId;

  @override
  @deprecated
  String apiUrl() =>
      SettingsApp.vehiculeModelUrl + "/" + vehicleModelId.toString();

  @override
  String baseApiUrl() => SettingsApp.vehiculeModelUrl;
}

class MotoBrandsApi extends RefApi {
  @override
  String apiUrl() => SettingsApp.motoBrandsUrl;

  @override
  String baseApiUrl() => SettingsApp.motoBrandsUrl;
}

class MileagesApi extends RefApi {
  @override
  String apiUrl() => SettingsApp.mileagesUrl;

  @override
  String baseApiUrl() => SettingsApp.mileagesUrl;
}

class YearsModelsApi extends RefApi {
  @override
  String apiUrl() => SettingsApp.yearsModelsUrl;

  @override
  String baseApiUrl() => SettingsApp.yearsModelsUrl;
}

class AdvertTypesApi extends RefApi {
  int advertTypeId;

  @override
  @deprecated
  String apiUrl() => SettingsApp.advertTypesUrl + advertTypeId.toString();

  @override
  String baseApiUrl() => SettingsApp.advertTypesUrl;
}

class CategoryAbuseApi extends RefApi {
  @override
  @deprecated
  String apiUrl() => baseApiUrl();

  @override
  String baseApiUrl() => SettingsApp.categoryAbuseUrl;
}
