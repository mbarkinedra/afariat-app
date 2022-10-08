import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../config/settings_app.dart';
import '../../model/favorite_list.dart';
import '../../networking/api/advert_api.dart';
import '../../networking/api/advert_details_api.dart';
import '../../networking/json/advert_details_json.dart';
import '../../networking/json/advert_list_json.dart';
import '../../networking/json/advert_minimal_json.dart';
import '../../storage/AccountInfoStorage.dart';

class SimilarAdvertsViewController extends GetxController {
  final PagingController<int, AdvertMinimalJson> pagingController =
      PagingController(firstPageKey: 0);
  final AdvertApi _api = AdvertApi();
  AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();
  ScrollController scrollController = ScrollController();
  RxBool isLoadingMore = false.obs;
  RxBool noMoreResults = false.obs;

  AdvertListJson advertListJson;
  RxBool isGrid = true.obs;
  String advertId;
  AdvertDetailsJson advert;
  final AdvertDetailsApi _advertDetailsApi = AdvertDetailsApi();
  static const double kToolbarHeight = 60;
  static const double expandedHeight = 250;
  static const double expandedMaxImgHeight = 190;

  RxBool isSliverAppBarCollapsed = false.obs;
  RxDouble imgWidth = expandedMaxImgHeight.obs;
  RxDouble imgHeight = expandedMaxImgHeight.obs;

  @override
  void onInit() {
    advertId = Get.parameters['id'];

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent) {
          swipeUp();
        }
      }
      isSliverAppBarCollapsed.value = scrollController.hasClients &&
          (scrollController.offset - expandedHeight > 0);
      if (isSliverAppBarCollapsed.value) {
        imgWidth.value = 0;
        imgHeight.value = 0;
      } else {
        if (scrollController.offset <= 0) {
          imgWidth.value = expandedMaxImgHeight;
          imgHeight.value = expandedMaxImgHeight;
        } else {
          double _w = expandedMaxImgHeight - scrollController.offset;
          double _h = expandedMaxImgHeight - scrollController.offset;
          if (_w <= 0 || _h <= 0) {
            // if negative values set 0
            _w = _h = 0;
          }
          imgWidth.value = _w;
          imgHeight.value = _h;
        }
      }
    });
    super.onInit();
  }

  Future<void> fetchPage([String url]) async {
    try {
      String _url = (url == null)
          ? _api.baseApiUrl()
          : url.startsWith('https://')
              ? url
              : SettingsApp.baseUrl + url;
      if (accountInfoStorage.isLoggedIn()) {
        await _api.secureGetCollection(_url).then((value) {
          onFetchApiSuccess(value);
        });
      } else {
        await _api.getCollection(_url).then((value) {
          onFetchApiSuccess(value);
        });
      }
    } catch (error) {
      throw error;
      pagingController.error = error;
    }
  }

  @override
  Future<dynamic> fetchInitialData() async {
    advert = await _advertDetailsApi.getAdvert(advertId);
    String _url = SettingsApp.similarAdvert + '/' + advertId.toString();
    fetchPage(_url);
    return advert;
  }

  @override
  void dispose() {
    scrollController.dispose();
    pagingController.dispose();
    super.dispose();
  }

  Future<void> swipeUp() async {
    isLoadingMore.value = true;
    if (!hasNextResults()) {
      isLoadingMore.value = false;
      noMoreResults.value = true;
      return;
    } else {
      isLoadingMore.value = false;
    }
  }

  Future<void> swipeDown() async {
    pagingController.itemList?.clear();
    pagingController.refresh(); //refreshes the UI
    noMoreResults.value = false;
    onSwipeDown();
  }

  @override
  Future<void> onSwipeDown() async {
    await fetchPage(advertListJson.links.firstUrl);
  }

  @override
  bool hasNextResults() => advertListJson.links.next != null;

  @override
  onFetchApiSuccess(value) {
    advertListJson = value;
    pagingController.appendLastPage(advertListJson.adverts());
    _setFavorites();
  }

  _setFavorites() {
    advertListJson?.adverts()?.forEach((advert) {
      if (advert.isFavorite == true) {
        FavoriteList.add(advert.id);
      }
    });
  }
}
