import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

class GetSaltApi extends ApiManager{
  @override
  String apiUrl() {
    return SettingsApp.getSaltUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

}