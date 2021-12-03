import 'package:afariat/networking/api/advert_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TapHomeViewController extends GetxController {
  AdvertApi _advertApi = AdvertApi();
  PriceApi _pricesApi = PriceApi();
  var box = GetStorage();
  bool getdatafromweb = true;
  List<AdvertJson> adverts = [];
  List<dynamic> prices = [];
  int maxValue = 20;
  int minValue = 0;
  SfRangeValues values = SfRangeValues(0, 100000);

  @override
  void onInit() {
    super.onInit();
    updatedata();
    getPriceList();
  }

  updatedata() async {
    await _advertApi.getList().then((value) {
      adverts = value.embedded.adverts;
      getdatafromweb = false;
    });
    update();
  }

  filterupdate() {}

  getPriceList() async {
    await _pricesApi.getList().then((value) {
      prices = value.data;
      minValue = prices[0].id;
      maxValue = prices[prices.length-1].id;
      values = SfRangeValues(minValue, maxValue);
      print(prices[prices.length-1].id);
    });
    update();
  }

  updateslidval(value) {
    values = value;
    update();
  }
}
