import 'package:afariat/config/filter.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';

import 'package:afariat/networking/api/categories_groupped_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/advert_details_json.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:get/get.dart';

class CategoryAndSubcategory extends GetxController {
  final CategoriesGrouppedApi _categoriesGrouppedApi = CategoriesGrouppedApi();
  final tapHomeViewController = Get.find<TapHomeViewController>();
  Map<int, List<SubcategoryJson>> sc = {};
  List<SubcategoryJson> listeSubCategories = [];
  SubcategoryJson subcategories1;
  List<CategoryGroupedJson> categoryGroupList = [];
  CategoryGroupedJson categoryGroupedJson;
  AdvertTypesApi _refApi = AdvertTypesApi();
  final tapPublishViewController = Get.find<TapPublishViewController>();

  @override
  void onInit() {
    super.onInit();
    _categoriesGrouppedApi.getList().then((value) {
      categoryGroupList = value.data;
      for (var element in categoryGroupList) {
        sc[element.id] = element.subcategories;
      }
      // Inserez tout les categories index[0]
      categoryGroupList.insert(0, CategoryGroupedJson(id: 0, name: "Category"));
      update();
    });
  }

  clearData() {
    categoryGroupedJson = null;
    subcategories1 = null;
    update();
  }

  updateCategorie(CategoryGroupedJson categoryGrouped) {
    if (categoryGrouped.id == 0) {
      if (Filter.data["category"] != null) {
        Filter.data.remove("category");
      }

      tapHomeViewController.filterUpdate();
    } else {
      Filter.data["category"] = categoryGrouped.id;
      tapHomeViewController.setSearch("category", categoryGrouped.id);
      print(Filter.data.toString());
      categoryGroupedJson = categoryGrouped;
      tapPublishViewController.updateCategory(categoryGrouped);
      subcategories1 = null;
      listeSubCategories = sc[categoryGrouped.id];
    }

    update();
  }

  updateSubCategorie(SubcategoryJson subCategorie) {
    subcategories1 = subCategorie;
    tapHomeViewController.setSearch("category", subCategorie.id);

    tapPublishViewController.updateSubCategoryJson(subCategorie);
    tapPublishViewController
        .updateGetView(RefJson(id: subCategorie.id, name: subCategorie.name));
    tapPublishViewController.myAds["category"] = subCategorie.id;
    tapPublishViewController.myAdsView["category"] = subCategorie.name;
    _categoriesGrouppedApi.categoryId = subCategorie.id;
    _refApi.advertTypeId = subCategorie.id;
    _refApi.getList().then((value) {
      print(value.data);
      Get.find<TapPublishViewController>().updateadvertTypes(value);
    });
    update();
  }
}
