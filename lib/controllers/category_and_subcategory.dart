import 'package:afariat/networking/api/categories_groupped_api.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:get/get.dart';
class CategoryAndSubcategory extends GetxController{
  final CategoriesGrouppedApi _categoriesGrouppedApi=CategoriesGrouppedApi();
  Map<int, List<SubcategoryJson>> sc = {};
  List<SubcategoryJson> listSubcategories = [];
  SubcategoryJson subcategories1;
  List<CategoryGroupedJson> categoryGroupList = [];
  CategoryGroupedJson categoryGroupedJson;
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


  updateCategorie(CategoryGroupedJson cat){
    categoryGroupedJson=cat;
    subcategories1 = null;
    listSubcategories=  sc[cat.id];

    update();
  }
  updateSupCategorie(SubcategoryJson cat){
    subcategories1=cat;

    update();

  }
}