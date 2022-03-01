import 'package:afariat/config/filter.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
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
  RxBool showSearch = false.obs;
  AdvertApi _advertApi = AdvertApi();
  PriceApi _pricesApi = PriceApi();
  AdvertPageApi _advertPageApi = AdvertPageApi();
  var box = GetStorage();
  bool getDataFromWeb = true;
  List<AdvertJson> adverts = [];
  List<dynamic> prices = [];
  int maxValue = 20;
  int minValue = 0;
  SfRangeValues values = SfRangeValues(0, 100000);
  Map<String, dynamic> search = {};
  bool loadPrice = true;
  static const _pageSize = 20;
  String searchAddLinke = "?";
  String priceSearch = "";
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();
  int page = 1;

  getAllAds() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(page);
    });
    updateData();
    getPriceList();
  }

  @override
  void onInit() {
    super.onInit();
    getAllAds();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      _advertPageApi.page = page;
      page++;
      print(_advertPageApi.page);
      final data = await _advertPageApi.getList();
      final newItems = data.embedded.adverts;
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  updateData() async {
    await _advertApi.getList().then((value) {
      adverts = value.embedded.adverts;

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
    if (searchWord.text.isNotEmpty) {
      setSearch("search", searchWord.text.toString());
      searchAddLinke = searchAddLinke + "search=${searchWord.text}&";
    }
    searchAddLinke = searchAddLinke + priceSearch;
    SearchApi searchApi = SearchApi(search);
    searchApi.searchData = searchAddLinke;
    print(Filter.data.toString());
    print(searchApi.apiUrl());
    searchApi.getList(filters: Filter.data).then((value) {
      clearPrice();
      pagingController.itemList.clear();
      adverts.clear();
      adverts = value.embedded.adverts;
      pagingController.appendLastPage(adverts);
      Get.find<LocController>().clearData();
      Get.find<CategoryAndSubcategory>().clearData();
      print(value.embedded.adverts.toString());
      searchAddLinke = "?";
      update();
    });
  }

  setSearch(String key, v) {
    search[key] = v;
    Filter.data[key] = v;
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

  clearPrice() {
    minValue = prices[0].id;
    maxValue = prices[prices.length - 1].id;
    values = SfRangeValues(minValue, maxValue);
    update();
  }

  updateSlideValue(value) {
    values = value;
    Filter.data["minPrice="] = prices[values.start.toInt() - 1].id;
    Filter.data["maxPrice="] = prices[values.end.toInt() - 1].id;
    priceSearch =
        "minPrice=${values.start.toInt().toString()}&maxPrice=${values.end.toInt().toString()}&";
    update();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
