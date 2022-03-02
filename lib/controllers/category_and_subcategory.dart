import 'package:afariat/config/filter.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/networking/api/categories_groupped_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:get/get.dart';

class CategoryAndSubcategory extends GetxController {
  int index = 0;
  final CategoriesGrouppedApi _categoriesGrouppedApi = CategoriesGrouppedApi();
  final tapHomeViewController = Get.find<TapHomeViewController>();
  Map<int, List<SubcategoryJson>> sc = {};

  List<SubcategoryJson> listeSubCategories = [];
  SubcategoryJson subcategories1;
  CategoryGroupedJson categoryGroupedJson;
  List<CategoryGroupedJson> categoryGroupList = [];

  AdvertTypesApi _refApi = AdvertTypesApi();
  final tapPublishViewController = Get.find<TapPublishViewController>();

  @override
  void onInit() {
    super.onInit();
    _categoriesGrouppedApi.getList().then((value) {
      categoryGroupList = value.data;

      for (var element in categoryGroupList) {
        element.subcategories.insert(0, SubcategoryJson(id: 0, name: ""));

        sc[element.id] = element.subcategories;
      }
      categoryGroupList.insert(0, CategoryGroupedJson(id: 0, name: ""));

      update();
    });
  }

  clearData() {
    categoryGroupedJson = null;
    subcategories1 = null;
    update();
  }

  updateCategory(CategoryGroupedJson categoryGrouped) {
    if (categoryGrouped.id == 0) {
      if (Filter.data["category"] != null) {
        Filter.data.remove("category");
      }

      tapHomeViewController.filterUpdate();
    } else {
      tapHomeViewController.searchAddLinke =
          tapHomeViewController.searchAddLinke +
              "category=${categoryGrouped.id}&";
      Filter.data["category"] = categoryGrouped.id;
      tapHomeViewController.setSearch("category", categoryGrouped.id);
      print(Filter.data.toString());
      categoryGroupedJson = categoryGrouped;
      tapPublishViewController.updateCategory(categoryGrouped);
      tapPublishViewController.updateGetView(null);
      subcategories1 = null;

      listeSubCategories = sc[categoryGrouped.id];
    }

    update();
  }

  updateSubCategory(SubcategoryJson subCategorie) {
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

      update();
    });
  }
}
