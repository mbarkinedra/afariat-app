import 'package:afariat/config/filter.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/networking/api/categories_groupped_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:get/get.dart';

import 'network_controller.dart';

class CategoryAndSubcategory extends GetxController {
  final CategoriesGrouppedApi _categoriesGrouppedApi = CategoriesGrouppedApi();
  final tapHomeViewController = Get.find<TapHomeViewController>();
  final tapPublishViewController = Get.find<TapPublishViewController>();
  Map<int, List<SubcategoryJson>> sc = {};
  List<SubcategoryJson> listSubCategories = [];
  SubcategoryJson subcategories1;
  CategoryGroupedJson categoryGroupedJson;
  List<CategoryGroupedJson> categoryGroupList = [];
  AdvertTypesApi _refApi = AdvertTypesApi();

  @override
  void onInit() {
    super.onInit();
    getCategoryGrouppedApi();
  }

  getCategoryGrouppedApi() {
    if (Get.find<NetWorkController>().connectionStatus.value) {
      _categoriesGrouppedApi.getList().then((value) {
        categoryGroupList = value.data;

        for (var element in categoryGroupList) {
          element.subcategories.insert(0, SubcategoryJson(id: 0, name: ""));

          sc[element.id] = element.subcategories;
        }
        categoryGroupList.insert(0, CategoryGroupedJson(id: 0, name: ""));
        listSubCategories = [];
        subcategories1 = null;
        update();
      });
    }
  }

  clearDataCategroyAndSubCategory() {
    categoryGroupedJson = null;
    subcategories1 = null;
    update();
  }

  updateCategory(CategoryGroupedJson categoryGrouped) {
    if (categoryGrouped.id == 0) {
      if (Filter.data["categoryGroup"] != null) {
        Filter.data.remove("categoryGroup");
        tapHomeViewController.search.remove("categoryGroup");
      }
      categoryGroupedJson = categoryGrouped;
      tapHomeViewController.filterUpdate();
    } else {
      Filter.data["categoryGroup"] = categoryGrouped.id;
      tapHomeViewController.setSearch("categoryGroup", categoryGrouped.id);

      categoryGroupedJson = categoryGrouped;
      tapPublishViewController.updateCategory(categoryGrouped);
      tapPublishViewController.updateGetView(null);
      subcategories1 = null;

      listSubCategories = sc[categoryGrouped.id];
    }
    update();
  }

  updateSubCategory(SubcategoryJson subCategorieJson) {
    if (subCategorieJson.id == 0) {
      tapHomeViewController.setSearch("categoryGroup", categoryGroupedJson.id);
      subcategories1 = subCategorieJson;
      if (tapHomeViewController.search["category"] != null) {
        tapHomeViewController.search.remove("category");
      }

      tapPublishViewController.updateSubCategoryJson(subCategorieJson);
      update();
    } else {
      subcategories1 = subCategorieJson;
      tapHomeViewController.setSearch("category", subCategorieJson.id);
      tapHomeViewController.search.remove("categoryGroup");
      tapPublishViewController.updateSubCategoryJson(subCategorieJson);
      tapPublishViewController.updateGetView(
          RefJson(id: subCategorieJson.id, name: subCategorieJson.name));
      tapPublishViewController.myAds["category"] = subCategorieJson.id;
      tapPublishViewController.myAdsView["category"] = subCategorieJson.name;
      _categoriesGrouppedApi.categoryId = subCategorieJson.id;
      _refApi.advertTypeId = subCategorieJson.id;
      _refApi.getList().then((value) {
        Get.find<TapPublishViewController>().updateAdvertTypes(value);

        update();
      });
    }
  }
}
