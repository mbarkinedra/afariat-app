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
      update();
    });
  }

  updateCategorie(CategoryGroupedJson cat) {
    categoryGroupedJson = cat;
    tapPublishViewController.updatecategory(cat);
    subcategories1 = null;
    listSubcategories = sc[cat.id];

    update();
  }

  updateSupCategorie(SubcategoryJson subCat) {
    subcategories1 = subCat;
    tapHomeViewController.setsearch("category", subCat.id);

    tapPublishViewController.updateSubcategoryJson(subCat);
    tapPublishViewController.updategetview(RefJson(id: subCat.id,name: subCat.name));
    tapPublishViewController.myAds["category"] =  subCat.id;
    tapPublishViewController.myAdsview["category"] =  subCat.name;
   Filter.Id = subCat.id.toString();

    _refApi.getList().then((value) {
      print(value.data);
     // Get.find<TapPublishViewController>(). getMotosBrand()  ;
      Get.find<TapPublishViewController>().updateadvertTypes(value);
      Filter.Id = null;
    });
    update();
  }
}
