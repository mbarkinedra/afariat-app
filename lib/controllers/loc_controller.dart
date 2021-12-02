
import 'package:afariat/networking/apis/get_cities_api.dart';
import 'package:afariat/networking/apis/get_towns_api.dart';

import 'package:afariat/networking/jsonfile/cities_json.dart';
import 'package:afariat/networking/jsonfile/towns_json.dart';
import 'package:get/get.dart';

class LocController extends GetxController{
  final GetCitiesApi _citiesApi=GetCitiesApi();
  final GetTownsApi _townsApi=GetTownsApi();
  List<Citie> cities;
  Citie citie;
  List<Town> data;
  @override
  void onInit() {
    super.onInit();
    _citiesApi.cities().then((value) {
      cities=value.data;
      update();
    });
  }
  updatecitie(Citie ci){
    citie=ci;
    updateTowns( ci.id);
    update();
  }

  updateTowns(id){
    _townsApi.towns(id).then((value) {
      data=value.data;
      update();
    });
  }

}