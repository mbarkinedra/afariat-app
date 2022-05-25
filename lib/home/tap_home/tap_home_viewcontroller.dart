import 'dart:developer';

import 'package:afariat/controllers/filter_controller.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/networking/api/advert_api.dart';
import 'package:afariat/networking/api/delete_favorite.dart';
import 'package:afariat/networking/api/favorite_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/networking/json/favorite_json.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_view_controller.dart';

class TapHomeViewController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();
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
  FavoriteJson favoriteJson = FavoriteJson();
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();
  List text = [
    'Hello ! Voici les principales fonctionnalités de l\'appication.\n\n'
        'Pour consulter les paramétres de l\'application appuyer sur le Logo.',
    'Recherchez des annonces ici.',
    'Filtrer le résultat de votre recherche',
  ];

  @override
  void onInit() {
    super.onInit();

    if (Get.find<NetWorkController>().connectionStatus.value) {
      //getFavorite();
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

  scrollUp() {
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
        // getFavorite();
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
      FilterController.setDataFilter(
          key: "search", val: searchWord.text.toString());
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

    FilterController.setDataFilter(
        key: "minPrice", val: values.start.toInt().toString());
    FilterController.setDataFilter(
        key: "maxPrice", val: values.end.toInt().toString());
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

  // Start introduction une seule fois
  startIntro(context) {
    if (accountInfoStorage.readIntro() == null) {
      intro.start(context);
      accountInfoStorage.saveIntro("intro");
    }
  }

  Intro intro;

  @override
  void onReady() {
    super.onReady();

    intro = Intro(
      /// You can set it true to disable animation
      noAnimation: false,

      /// The total number of guide pages, must be passed
      stepCount: 3,

      /// Click on whether the mask is allowed to be closed.
      maskClosable: true,

      /// When highlight widget is tapped.
      onHighlightWidgetTap: (introStatus) {},

      /// The padding of the highlighted area and the widget
      padding: EdgeInsets.all(8),

      /// Border radius of the highlighted area
      borderRadius: BorderRadius.all(Radius.circular(4)),

      /// Use the default useDefaultTheme provided by the library to quickly build a guide page
      /// Need to customize the style and content of the guide page, implement the widgetBuilder method yourself
      /// * Above version 2.3.0, you can use useAdvancedTheme to have more control over the style of the widget
      /// * Please see https://github.com/tal-tech/flutter_intro/issues/26
      widgetBuilder: StepWidgetBuilder.useAdvancedTheme(
        widgetBuilder: (params) {
          return Container(
            child: Column(
              children: [
                Text(
                  text[params.currentStepIndex],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    if (params.currentStepIndex + 1 < params.stepCount)
                      InkWell(
                        onTap: () {
                          params.onNext();
                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            child: Text(
                              'Suivant',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    if (params.currentStepIndex + 1 == params.stepCount)
                      InkWell(
                        onTap: () {
                          params.onFinish();
                          Get.find<HomeViwController>().startIntro1();
                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            child: Text(
                              'Suivant',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
