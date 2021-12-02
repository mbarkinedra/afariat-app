
import 'package:afariat/networking/apis/get_advert_api.dart';
import 'package:afariat/networking/apis/get_prices_api.dart';
import 'package:afariat/networking/jsonfile/adverts_json.dart';
import 'package:afariat/networking/jsonfile/prices_json.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TapHomeViewController extends GetxController {
  GetAdvertApi _advertApi = GetAdvertApi();
  GetPricesApi _pricesApi=GetPricesApi();
  var box = GetStorage();
  bool getdatafromweb = true;
  List<Adverts> adverts=[];
  List<Prices> prices=[];
  double  maxValue=100000;
  double  minValue=0.0;
  SfRangeValues  values = SfRangeValues(0, 100000);
  @override
  void onInit() {
    super.onInit();
    updatedata();
    getPriceList();

  }

  updatedata() async {
    await _advertApi.getadverts().then((value) {
      adverts = value.embedded.adverts;
      getdatafromweb = false;
    });
    update();
  }
  filterupdate(){

  }
  getPriceList()async {
    await _pricesApi.prices().then((value) {
      prices=value.data;
      gethighprice();
    });
    update();
  }
  // updatdropdownMaxValue(Prices val){
  //    dropdownMaxValue=val;
  //    update();
  // }
  // updatdropdownminValue(Prices val){
  //   dropdownminValue=val;
  //   update();
  // }
  updateslidval(value){

    values =value;
    update();
  }

  gethighprice(){
    for(Prices price in prices){
      if(maxValue<double.tryParse(price.name)){
        maxValue=double.parse(price.name);
      }
    }
    values = SfRangeValues(minValue, maxValue);
    update(); }
}