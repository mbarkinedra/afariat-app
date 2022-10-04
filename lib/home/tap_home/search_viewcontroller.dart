import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../Common/abstract_paginated_view_controller.dart';
import '../../config/settings_app.dart';
import '../../model/favorite_list.dart';
import '../../model/filter.dart';
import '../../networking/api/advert_api.dart';
import '../../networking/json/advert_list_json.dart';
import '../../networking/json/advert_minimal_json.dart';

class SearchViewController
    extends AbstractPaginatedViewController<AdvertMinimalJson> {
  AdvertListJson advertListJson;
  RxBool isGrid = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> fetchInitialData() async {
    String httpQuery = Filter.toHttpQuery();
    fetchPage(apiInstance().generateUrl(httpQuery));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  AdvertApi apiInstance() {
    if(api == null) {
      return AdvertApi();
    }
    return api;
  }

  @override
  Future<void> onSwipeUp() async {
    await fetchPage(advertListJson.links.nextUrl);
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

  //TODO: make search based on the filter values
  Future<void> makeSearch() async {
    pagingController.itemList?.clear();
    try {
      await apiInstance().getAdverts(httpQuery:  Filter.toHttpQuery()).then((value) {
        //TODO: save the filter in local storage
        onFetchApiSuccess(value);
      });

    } catch (error) {
      print(error);
      pagingController.error = error;
    }
  }
}
