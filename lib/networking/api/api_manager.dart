import 'package:afariat/config/dio_singleton.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();

  /// Returns the API URL of current API ressource
  String apiUrl();

  AbstractJsonResource fromJson(data);


  Future<dynamic> getList( ) async {
   print(Filter.m.toString());
    AbstractJsonResource jsonList;
    var data;
    await dioSingleton.dio.get(Filter.Id==null?apiUrl():apiUrl()+Filter.Id,queryParameters:Filter.m).then((value) {
      data = value.data;
    });
    jsonList = fromJson(data);

    return jsonList;
  }
}
