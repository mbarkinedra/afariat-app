import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/networking/api/advert_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:url_launcher/url_launcher.dart';

class TapHomeViewController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController searchWord = TextEditingController();
  RxBool showSearch = false.obs;
  AdvertApi _advertApi = AdvertApi();
  PriceApi _pricesApi = PriceApi();
  var box = GetStorage();
  bool getDataFromWeb = true;

  //List<AdvertJson> adverts = [];
  AdvertListJson advertListJson;
  List<dynamic> prices = [];
  int maxValue = 20;
  int minValue = 0;
  SfRangeValues values = SfRangeValues(0, 100000);
  Map<String, dynamic> search = {};
  bool loadPrice = true;
  String searchAddLinke = "";

  String name = "";
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();
  String url = '';

  getAllAds() {
    if (Get.find<NetWorkController>().connectionStatus.value) {
      pagingController.addPageRequestListener((pageKey) {
        _fetchPage();
      });
      updateData();
      getPriceList();
    }
  }

  onSwipeUp() {
    if (advertListJson.links.next == null) {
      _fetchPage(advertListJson.links.getLastUrl());
    } else {
      _fetchPage(advertListJson.links.getNextUrl());
    }
  }

  onSwipeDown() {
  //  if(   pagingController.itemList!=null){
      pagingController.itemList?.clear();
   // }

    if (advertListJson.links.previous == null) {
      print("getFirstUrl");
      _fetchPage(advertListJson.links.getFirstUrl());
    } else {
      _fetchPage(advertListJson.links.getPreviousUrl());
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.find<NetWorkController>().connectionStatus.value) {
      getAllAds();
    }

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent) {
          print("onSwipeUp");
          onSwipeUp();
        } else if (scrollController.offset >=
            scrollController.position.minScrollExtent) {
          print("onSwipeDown");
          onSwipeDown();
        }
      }
      ;
    });

  }



  setUserName(String v) {
    name = v;
    update();
  }

  Future<void> _fetchPage([String url]) async {
    try {
      _advertApi.url = url;
      await _advertApi.getList().then((value) {
        advertListJson = value;
        getDataFromWeb = false;
      });

      pagingController.appendLastPage(advertListJson.adverts());
      update();
    } catch (error) {
      pagingController.error = error;
    }
  }

  clearData() {
    _advertApi.url = null;
    Filter.data.clear();
    pagingController.refresh();

  }

  updateData() async {
    await _advertApi.getList().then((value) {
      advertListJson = value;
      getDataFromWeb = false;
    });
    update();
  }

  filterWord(v) {
    update();
  }

  filterClear() {
    searchWord.clear();
    update();
  }

  filterUpdate() {
    //reset the URL of advertApi
    _advertApi.url = null;

    if (searchWord.text.isNotEmpty) {
      Filter.data['search'] = searchWord.text.toString();
    }

    _advertApi.getList().then((value) {
      pagingController.itemList.clear();
      advertListJson = value;
      resetPriceSlider();
      pagingController.appendLastPage(advertListJson.adverts());

      //go top after getting ads
      scrollController
        ..animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );

      Get.find<LocController>().clearData();
      Get.find<CategoryAndSubcategory>().clearData();
      Get.find<TapHomeViewController>().search.clear();
      update();
    });
  }

  setSearch(String key, v) {
    search[key] = v;
  }

  getPriceList() async {
    await _pricesApi.getList().then((value) {
      prices = value.data;
      minValue = prices[0].id;
      maxValue = prices[prices.length - 1].id;
      values = SfRangeValues(minValue, maxValue);

      loadPrice = false;
    });
    update();
  }

  resetPriceSlider() {
    minValue = prices[0].id;
    maxValue = prices[prices.length - 1].id;
    values = SfRangeValues(minValue, maxValue);
    update();
  }

  updateSlideValue(value) {
    values = value;
    Filter.data["minPrice="] = prices[values.start.toInt() - 1].id;
    Filter.data["maxPrice="] = prices[values.end.toInt() - 1].id;

    Get.find<TapHomeViewController>()
        .setSearch("minPrice", values.start.toInt().toString());
    Get.find<TapHomeViewController>()
        .setSearch("maxPrice", values.end.toInt().toString());
    update();
  }

  openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
