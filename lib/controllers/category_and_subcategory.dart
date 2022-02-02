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
  List<SubcategoryJson> listSubcategories = [];
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
      categoryGroupList.insert(
          0, CategoryGroupedJson(id: 0, name: "all category"));
      update();
    });
  }

  clearData() {
    categoryGroupedJson = null;
    subcategories1 = null;
    update();
  }

  updateCategorie(CategoryGroupedJson cat) {
    if (cat.id == 0) {
      if (Filter.data["category"] != null) {
        Filter.data.remove("category");
      }

      tapHomeViewController.filterUpdate();
      print("iiiiiiiiiiiiiiiiiiii");
    } else {
      Filter.data["category"] = cat.id;
      tapHomeViewController.setsearch("category", cat.id);
      print(Filter.data.toString());
      categoryGroupedJson = cat;
      tapPublishViewController.updatecategory(cat);
      subcategories1 = null;
      listSubcategories = sc[cat.id];
    }

    update();
  }

  updateSupCategorie(SubcategoryJson subCat) {
    // Filter.data["category"]=subCat.id;
    // print(   Filter.data.toString());
    subcategories1 = subCat;
    tapHomeViewController.setsearch("category", subCat.id);

    tapPublishViewController.updateSubcategoryJson(subCat);
    tapPublishViewController
        .updategetview(RefJson(id: subCat.id, name: subCat.name));
    tapPublishViewController.myAds["category"] = subCat.id;
    tapPublishViewController.myAdsview["category"] = subCat.name;
    _categoriesGrouppedApi.categoryId = subCat.id;
    _refApi.advertTypeId = subCat.id;
    _refApi.getList().then((value) {
      print(value.data);
      Get.find<TapPublishViewController>().updateadvertTypes(value);
    });
    update();
  }
}
