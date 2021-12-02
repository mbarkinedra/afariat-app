import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/jsonfile/adverts_json.dart';

class GetAdvertApi{
  DioSingleton _dioSingleton=DioSingleton();

  Future <AdvertsJson > getadverts()async{

    AdvertsJson  advertsJson;
    var data;
    final formData = {

      "apikey": SettingsApp.apiKey,
    };

    await _dioSingleton.dio.get(SettingsApp.Advert,queryParameters: formData).then((value) {

      data=value.data;
    });
    advertsJson=AdvertsJson.fromJson(data);

    return advertsJson;
  }
}