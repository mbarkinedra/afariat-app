import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/jsonfile/prices_json.dart';

class GetPricesApi{
  DioSingleton _dioSingleton=DioSingleton();
  Future <PricesJson > prices()async{
    PricesJson  advertsJson  ;
    var data;
    final formData = {

      "apikey": SettingsApp.apiKey,
    };

    await _dioSingleton.dio.get(SettingsApp.price,queryParameters: formData).then((value) {

      data=value.data;
    });
    advertsJson=PricesJson.fromJson(data);

    return advertsJson;
  }
}