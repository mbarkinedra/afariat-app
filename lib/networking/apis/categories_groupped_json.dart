import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/jsonfile/categories_groupped_json.dart';

class GetCategoriesGrouppedApi{
  final DioSingleton _dioSingleton=DioSingleton();
  Future <CategoriesGrouppedJson > categoriesGroupped()async{
    CategoriesGrouppedJson  categoriesGrouppedJson  ;
    var data;
    final formData = {

      "apikey": SettingsApp.apiKey,
    };

    await _dioSingleton.dio.get(SettingsApp.categories,queryParameters: formData).then((value) {

      data=value.data;

    });
    categoriesGrouppedJson=CategoriesGrouppedJson.fromJson(data);

    return categoriesGrouppedJson;
  }

}