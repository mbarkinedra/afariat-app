import 'package:afariat/controllers/filter_controller.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/networking/api/advert_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:url_launcher/url_launcher.dart';

class TapHomeViewController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController searchWord = TextEditingController();
  AdvertApi _advertApi = AdvertApi();
  PriceApi _pricesApi = PriceApi();
  bool getDataFromWeb = true;
  AdvertListJson advertListJson;
  List<dynamic> prices = [];
  int maxValuePrice = 20;
  int minValuePrice = 0;
  SfRangeValues values = SfRangeValues(0, 100000);
  Map<String, dynamic> search = {};
  bool loadPrice = true;
  String url = '';
  String name = "";
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();

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
          onSwipeUp();
        } else if (scrollController.offset >=
            scrollController.position.minScrollExtent) {
          onSwipeDown();
        }
      }
    });
  }

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
    print(advertListJson.links.getLastUrl());
    print(advertListJson.links.getNextUrl());
    if (advertListJson.links.next == null) {
      _fetchPage(advertListJson.links.getLastUrl());
    } else {
      _fetchPage(advertListJson.links.getNextUrl());
    }
  }

  onSwipeDown() {
    pagingController.itemList?.clear();

    if (advertListJson.links.previous == null) {
      _fetchPage(advertListJson.links.getFirstUrl());
    } else {
      _fetchPage(advertListJson.links.getPreviousUrl());
    }
  }
scrollUp(){

 scrollController.animateTo(
   1,
    curve: Curves.bounceOut,
    duration: const Duration(milliseconds: 200),
  );
}
//Set Name of drawer
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

//Lorsque on clique sur l 'icon home ,le package paging fait un appel la 1 ere page
  clearDataFilter() {
    _advertApi.url = null;
    //Get.find<TapHomeViewController>().search.clear();
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

  filterClearSearch() {
    searchWord.clear();
    update();
  }

  filterUpdate() {
    //reset the URL of advertApi
    _advertApi.url = null;
    if (searchWord.text.isNotEmpty) {
      FilterController
          .setDataFilter(key: "search", val: searchWord.text.toString() );
     // Filter.data['search'] = searchWord.text.toString();
    }
    _advertApi.getList().then((value) {
      print("hhhhhhhhhhhhhhhhhhhhhhhh ${value.toString()}");
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
      Get.find<LocController>().clearDataCityAndTown();
      Get.find<CategoryAndSubcategory>().clearDataCategroyAndSubCategory();
      FilterController.searchData.clear();
      update();
    });
  }

  setSearch(String key, v) {
    search[key] = v;
  }

  getPriceList() async {
    await _pricesApi.getList().then((value) {
      prices = value.data;
      minValuePrice = prices[0].id;
      maxValuePrice = prices[prices.length - 1].id;
      values = SfRangeValues(minValuePrice, maxValuePrice);

      loadPrice = false;
    });
    update();
  }

  resetPriceSlider() {
    minValuePrice = prices[0].id;
    maxValuePrice = prices[prices.length - 1].id;
    values = SfRangeValues(minValuePrice, maxValuePrice);
    update();
  }

  updateSlideValue(value) {
    values = value;

    // Filter.data["minPrice="] = prices[values.start.toInt() - 1].id;
    // Filter.data["maxPrice="] = prices[values.end.toInt() - 1].id;
    FilterController
        .setDataFilter(key: "minPrice",val: values.start.toInt().toString() );
    FilterController
        .setDataFilter(key: "maxPrice",val: values.end.toInt().toString() );
    // Get.find<TapHomeViewController>()
    //     .setSearch("minPrice", values.start.toInt().toString());
    // Get.find<TapHomeViewController>()
    //     .setSearch("maxPrice", values.end.toInt().toString());
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
