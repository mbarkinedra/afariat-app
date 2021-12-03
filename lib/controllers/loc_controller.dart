

import 'package:get/get.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/ref_json.dart';

class LocController extends GetxController{
  final CityApi _cityApi=CityApi();
  final TownApi _townsApi=TownApi();
  List<RefJson> cities=[];
  RefJson citie;
  List<RefJson> towns=[];
  RefJson town;
  @override
  void onInit() {
    super.onInit();
    _cityApi.getList().then((value) {

      cities=value.data  ;
      update();
    });
  }
  updatecitie(RefJson ci){
    citie=ci;
    town=null;
    updateTowns( ci.id.toString());
    update();
  }
  updatetown(RefJson tow){
    town=tow;

    update();
  }
  updateTowns(id){

    _townsApi.getList( id: id ).then((value) {
      towns=value.data;
      update();
    });
  }

}