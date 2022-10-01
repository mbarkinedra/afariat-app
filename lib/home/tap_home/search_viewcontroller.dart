import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../model/favorite_list.dart';
import '../../networking/api/advert_api.dart';
import '../../networking/json/advert_list_json.dart';
import '../../networking/json/advert_minimal_json.dart';

class SearchViewController extends GetxController {
  final PagingController<int, AdvertMinimalJson> pagingController =
      PagingController(firstPageKey: 0);
  ScrollController scrollController = ScrollController();
  final AdvertApi _api = AdvertApi();
  AdvertListJson advertListJson;
  RxBool isGrid = false.obs;
  RxBool isLoadingMore = false.obs;

  @override
  void onInit() {
    fetchPage();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent) {
          onSwipeUp();
        } /*else
          if (scrollController.offset >=
            scrollController.position.minScrollExtent) {
          onSwipeDown();
        }*/
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  /// fetch page
  Future<void> fetchPage([String url]) async {
    try {
      _api.url = url;
      await _api.getList().then((value) {
        advertListJson = value;
      });

      pagingController.appendLastPage(advertListJson.adverts());
      _setFavorites();
    } catch (error) {
      pagingController.error = error;
    }
  }

  _setFavorites() {
    advertListJson?.adverts()?.forEach((advert) {
      if (advert.isFavorite == true) {
        FavoriteList.add(advert.id);
      }
    });
  }

  ///make search based on the filter values
  Future<void> makeSearch() async {
    pagingController.refresh();
    try {
      await _api.getList().then((value) {
        advertListJson = value;
      });

      pagingController.appendLastPage(advertListJson.adverts());
      _setFavorites();
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> onSwipeUp() async {
    isLoadingMore.value = true;
    if (advertListJson.links.next == null) {
      await fetchPage(advertListJson.links.lastUrl);
    } else {
      await fetchPage(advertListJson.links.nextUrl);
      isLoadingMore.value = false;
    }
  }

  Future<void> swipeDown() async {
    pagingController.itemList?.clear();

    if (advertListJson.links.previous == null) {
      await fetchPage(advertListJson.links.firstUrl);
    } else {
      await fetchPage(advertListJson.links.previousUrl);
    }
  }
}
