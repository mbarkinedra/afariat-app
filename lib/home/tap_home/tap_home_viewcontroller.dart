import 'package:afariat/home/tap_home/favorite/favorite_viewController.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/networking/api/advert_api.dart';
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
  BuildContext context;

  //GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();
  TextEditingController searchWord = TextEditingController();
  List<int> favorites = [];
  AdvertApi _advertApi = AdvertApi();
  PriceApi _pricesApi = PriceApi();
  bool getDataFromWeb = true;
  AdvertListJson advertListJson;
  List<dynamic> prices = [];
  int maxValuePrice = 20;
  int minValuePrice = 0;
  SfRangeValues values = SfRangeValues(0, 100000);
  Map<String, dynamic> search = {};
  int loadOrScrollHome = 0;
  bool loadPrice = true;
  String url = '';
  String name = "";
  FavoriteJson favoriteJson = FavoriteJson();
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();
  List text = [
    'Hello ! Voici les principales fonctionnalités de l\'appication.\n\n'
        'Appuyer sur cette icone pour afficher le menu de l\'application.',
    'Recherchez des annonces ici.',
    'Filtrer le résultat de votre recherche',
    'Vos notifications'
  ];

  @override
  void onInit() {
    super.onInit();

    if (Get.find<NetWorkController>().connectionStatus.value) {
      getAllAdverts();
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

  Future<void> fetchPage([String url]) async {
    try {
      _advertApi.url = url;
      await _advertApi.getList().then((value) {
        advertListJson = value;
        getDataFromWeb = false;
        Get.find<FavoriteViewController>().getFavorite();
      });

      advertListJson.embedded.adverts.forEach((element) {
        if (element.isFavorite) {
          favorites.add(element.id);
        }
      });
      pagingController.appendLastPage(advertListJson.adverts());
      update();
    } catch (error) {
      pagingController.error = error;
    }
  }

  /// Scroll Up List Of adverts (first clic on home icon ) And Load List (second clic on home icon  )
  scrollUpHome() {
    loadOrScrollHome++;
    if (loadOrScrollHome == 1) {
      scrollUp();
    } else {
      if (scrollController.offset != 1) {
        scrollUp();
        loadOrScrollHome = 1;
      } else {
        clearDataFilter();
        loadOrScrollHome = 0;
      }
    }
  }

  // Add List favorite into home
  addToFavoritesList(int id) {
    favorites.add(id);
    if (pagingController.itemList != null) {
      pagingController.itemList.forEach((element) {
        if (favorites.contains(element.id)) {
          element.isFavorite = true;
        }
      });
    }
    update();
  }

  // delete List favorite into home
  deleteFromFavoritesList(int id) {
    favorites.remove(id);
    pagingController.itemList.forEach((element) {
      if (favorites.contains(element.id)) {
        element.isFavorite = true;
      } else {
        element.isFavorite = false;
      }
    });
    update();
  }

  // delete list favorite "logOut"
  deleteAllFavoritesList() {
    favorites.clear();
    if (pagingController.itemList != null) {
      pagingController.itemList.forEach((element) {
        element.isFavorite = false;
      });
    }
    update();
  }

  //Get all adverts
  getAllAdverts() {
    if (Get.find<NetWorkController>().connectionStatus.value) {
      pagingController.addPageRequestListener((pageKey) {
        fetchPage();
      });
      updateData();
      getPriceList();
    }
  }

  onSwipeUp() {
    if (advertListJson.links.next == null) {
      fetchPage(advertListJson.links.getLastUrl());
    } else {
      fetchPage(advertListJson.links.getNextUrl());
    }
  }

  onSwipeDown() {
    pagingController.itemList?.clear();

    if (advertListJson.links.previous == null) {
      fetchPage(advertListJson.links.getFirstUrl());
    } else {
      fetchPage(advertListJson.links.getPreviousUrl());
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

  ///When you click on the home icon, the paging package calls the 1st page
  clearDataFilter() {
    _advertApi.url = null;
    Filter.clear();
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
    filterUpdate();
  }

  filterClearSearch() {
    searchWord.clear();
    update();
  }

  filterUpdate() {
    //reset the URL of advertApi
    _advertApi.url = null;
    if (searchWord.text.isNotEmpty) {
      Filter.set("search", searchWord.text.toString());
    }
    _advertApi.getList(filters: Filter.parameters().data).then((value) {
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
      Filter.clear();
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

    Filter.set("minPrice",  values.start.toInt().toString());
    Filter.set( "maxPrice", values.end.toInt().toString());
    update();
  }

  /*openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }*/

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  updatecontext(v) {
    context = v;
  }

  // Start intro one time
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
      stepCount: 4,

      /// Click on whether the mask is allowed to be closed.
      maskClosable: true,

      /// When highlight widget is tapped.
      onHighlightWidgetTap: (introStatus) {},

      /// The padding of the

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
                          Get.find<HomeViewController>().startIntro1();
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
