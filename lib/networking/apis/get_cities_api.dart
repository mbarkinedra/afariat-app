import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/jsonfile/cities_json.dart';

class GetCitiesApi{
  final DioSingleton _dioSingleton=DioSingleton();
  Future <CitiesJson > cities()async{
    CitiesJson  citiesJson  ;
    var data;
    final formData = {

      "apikey": SettingsApp.apiKey,
    };

    await _dioSingleton.dio.get(SettingsApp.cities,queryParameters: formData).then((value) {

      data=value.data;

    });
    citiesJson=CitiesJson.fromJson(data);

    return citiesJson;
  }
}