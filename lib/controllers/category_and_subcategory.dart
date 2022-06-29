import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/networking/api/categories_groupped_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:get/get.dart';
import 'package:afariat/model/filter.dart';
import 'network_controller.dart';

class CategoryAndSubcategory extends GetxController {
  final CategoriesGrouppedApi _categoriesGrouppedApi = CategoriesGrouppedApi();
  final tapHomeViewController = Get.find<TapHomeViewController>();
  final tapPublishViewController = Get.find<TapPublishViewController>();
  Map<int, List<SubCategoryJson>> sc = {};
  List<SubCategoryJson> listSubCategories = [];
  SubCategoryJson subcategories1;
  CategoryGroupedJson categoryGroupedJson;
  List<CategoryGroupedJson> categoryGroupList = [];
  AdvertTypesApi _refApi = AdvertTypesApi();

  @override
  void onInit() {
    super.onInit();
    getCategoryGrouppedApi();
  }

  ///Get all data of category from api
  getCategoryGrouppedApi() {
    if (Get.find<NetWorkController>().connectionStatus.value) {
      _categoriesGrouppedApi.getList().then((value) {
        categoryGroupList = value.data;

        for (var element in categoryGroupList) {
          element.subcategories.insert(0, SubCategoryJson(id: 0, name: ""));

          sc[element.id] = element.subcategories;
        }
        categoryGroupList.insert(0, CategoryGroupedJson(id: 0, name: ""));
        listSubCategories = [];
        subcategories1 = null;
        update();
      });
    }
  }

  /// Clear all data category and subcategory
  clearDataCategroyAndSubCategory() {
    categoryGroupedJson = null;
    subcategories1 = null;
    update();
  }

  // Update all data of category from api
  updateCategory(CategoryGroupedJson categoryGrouped) {
    if (categoryGrouped.id == 0) {
      Filter.remove(key: "categoryGroup");
      subcategories1 = null;
      categoryGroupedJson = categoryGrouped;
    } else {
      Filter
          .set(key: "categoryGroup", val: categoryGrouped.id);
      categoryGroupedJson = categoryGrouped;
      tapPublishViewController.updateCategory(categoryGrouped);
      tapPublishViewController.updateGetView(null);
      subcategories1 = null;
      listSubCategories = sc[categoryGrouped.id];
    }
    update();
  }

  // Update all data of subcategory from api
  updateSubCategory(SubCategoryJson subCategorieJson) {
    subcategories1 = subCategorieJson;
    tapPublishViewController.updateSubCategoryJson(subCategorieJson);
    if (subCategorieJson.id == 0) {
      Filter
          .set(key: "categoryGroup", val: categoryGroupedJson.id);
      update();
    } else {
      Filter
          .set(key: "category", val: subCategorieJson.id);
      Filter.remove(key: "categoryGroup");
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
