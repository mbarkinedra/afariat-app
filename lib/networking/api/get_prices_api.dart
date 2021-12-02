import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/prices_json.dart';

class GetPricesApi{
  DioSingleton _dioSingleton=DioSingleton();
  Future <PricesJson > prices()async{
    PricesJson  advertsJson  ;
    var data;

    await _dioSingleton.dio.get(SettingsApp.priceUrl).then((value) {

      data=value.data;
    });
    advertsJson=PricesJson.fromJson(data);

    return advertsJson;
  }
}