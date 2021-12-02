import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/jsonfile/towns_json.dart';

class GetTownsApi{
  final DioSingleton _dioSingleton=DioSingleton();


  Future <TownsJson > towns(id)async{
    TownsJson  townsJson  ;
    var data;
    final formData = {

      "apikey": SettingsApp.apiKey,
    };

    await _dioSingleton.dio.get(SettingsApp.town+id,queryParameters: formData).then((value) {

      data=value.data;

    });
    townsJson=TownsJson.fromJson(data);

    return townsJson;
  }
}