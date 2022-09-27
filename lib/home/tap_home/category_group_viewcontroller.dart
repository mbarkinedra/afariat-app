import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/filter.dart';
import '../../networking/api/autocomplete_api.dart';
import '../../networking/api/categories_groupped_api.dart';
import '../../networking/json/categories_grouped_json.dart';
import '../../networking/json/localization_json.dart';
import '../../storage/AccountInfoStorage.dart';
import 'filter_app_bar_viewcontroller.dart';
import 'filter_viewcontroller.dart';

class CategoryGroupViewController extends GetxController {
  /*GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  GlobalKey keyCat = GlobalKey();*/

  //TODO: Init the list by the saved localizations in the storage
  CategoriesGroupedJsonList groupJsonList = CategoriesGroupedJsonList();
  final CategoriesGrouppedApi _api = CategoriesGrouppedApi();
  CategoryGroupedJson selectedGroup;

  @override
  void onInit() async {
    fetchGroups();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<CategoriesGroupedJsonList> fetchGroups() async {
    CategoriesGroupedJsonList groupJsonList = await _api.getList();
    return groupJsonList;
  }

  List<SubCategoryJson> getSelectedCategories(){
    return selectedGroup.subcategories;
  }

  selectGroup([CategoryGroupedJson group]) {
    selectedGroup = group;
    Filter.remove('category');
    if(group != null) {
      Filter.set('categoryGroup', group.id);
    }else{ //remove everything
      Filter.remove('categoryGroup');
      setFilterCategoryLabel('Toutes les catégories');
    }
    print(Filter.parameters().data);
  }

  selectCategory(SubCategoryJson subCategory){
    Filter.set('category', subCategory.id);
    //update the label selected category
    setFilterCategoryLabel(subCategory.name);
    print(Filter.parameters().data);
  }

  setFilterCategoryLabel(String label){
    Get.find<FilterViewController>().categoryLabel.value = label;
  }
}
