import 'package:afariat/config/filter.dart';
import 'package:afariat/networking/api/advertPage_api.dart';
import 'package:afariat/networking/api/advert_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/api/search_api.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TapHomeViewController extends GetxController {
  TextEditingController searchWord = TextEditingController();
  RxBool showsearch = false.obs;
  AdvertApi _advertApi = AdvertApi();
  PriceApi _pricesApi = PriceApi();
  AdvertPageApi _advertPageApi = AdvertPageApi();
  var box = GetStorage();
  bool getdatafromweb = true;
  List<AdvertJson> adverts = [];
  List<dynamic> prices = [];
  int maxValue = 20;
  int minValue = 0;
  SfRangeValues values = SfRangeValues(0, 100000);
  Map<String, dynamic> search = {};
  bool loadprice = true;
  static const _pageSize = 20;

  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    updatedata();
    getPriceList();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        _advertPageApi.page = page;
        _advertPageApi.getList().then((value) {
          page++;
          adverts.addAll(value.embedded.adverts);
          update();
        });
      } else if (scrollController.position.minScrollExtent ==
          scrollController.position.pixels) {
        _advertPageApi.page = 0;
        _advertPageApi.getList().then((value) {
          page = 1;
          adverts.clear();
          adverts = value.embedded.adverts;
          update();
        });
        print("ooooooooooooooooooooooooooooooooooooooooooooooooo");
      }
    });
  }

  getfirestpage() {}

  updatedata() async {
    await _advertApi.getList().then((value) {
      adverts = value.embedded.adverts;

      getdatafromweb = false;
    });
    update();
  }

  filterword(v) {
    update();
  }

  filterclear() {
    searchWord.clear();
    update();
  }

  filterupdate() {
    if (searchWord.text.isNotEmpty) {
      setsearch("search", searchWord.text.toString());
    }
    SearchApi a = SearchApi(search);
    print(Filter.data.toString());
    a.getList(filters: Filter.data).then((value) {
      adverts.clear();
      adverts = value.embedded.adverts;
      print(value.embedded.adverts.toString());
      update();
    });
  }

  setsearch(String key, v) {
    search[key] = v;
  }

  getPriceList() async {
    await _pricesApi.getList().then((value) {
      prices = value.data;
      minValue = prices[0].id;
      maxValue = prices[prices.length - 1].id;
      values = SfRangeValues(minValue, maxValue);

      loadprice = false;
    });
    update();
  }

  updateslidval(value) {
    values = value;
    update();
  }
}
