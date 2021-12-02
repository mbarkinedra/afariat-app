import 'package:afariat/networking/api/categories_groupped_json.dart';
import 'package:afariat/networking/json/categories_groupped_json.dart';
import 'package:get/get.dart';
class CategoryAndSubcategory extends GetxController{
  final GetCategoriesGrouppedApi _categoriesGrouppedApi=GetCategoriesGrouppedApi();
  Map<int, List<Subcategories>> sc = {};
  List<Subcategories> listSubcategories = [];
  Subcategories subcategories1;
  List<Categories> categories = [];
  Categories categorie;
  @override
  void onInit() {
    super.onInit();
    _categoriesGrouppedApi.getList().then((value) {
      categories = value.data;
      for (var element in categories) {
        sc[element.id] = element.subcategories;
      }
      update();
    });
  }


  updateCategorie(Categories cat){
    categorie=cat;
    subcategories1 = null;
    listSubcategories=  sc[cat.id];

    update();
  }
  updateSupCategorie(Subcategories cat){
    subcategories1=cat;

    update();

  }
}