import 'dart:io';
import 'dart:developer' as devlog;
import 'dart:convert';
import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/filter.dart';

import 'package:afariat/config/storage.dart';

import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_myads/tap_myads_viewcontroller.dart';
import 'package:afariat/model/validate_server.dart';
import 'package:afariat/model/validator.dart';
import 'package:afariat/mywidget/custom_dialogue_felecitation.dart';
import 'package:afariat/networking/api/modif_ads_api.dart';
import 'package:afariat/networking/api/publish_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:afariat/networking/json/modif_ads_json.dart';

import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../home_view_controller.dart';

class TapPublishViewController extends GetxController {
  RxBool buttonPublier = false.obs;

  RxBool modifAds = false.obs;
  bool getDataFromServer = false;
  RxString validateTown = "".obs;
  RxString validateCity = "".obs;
  RxString validateCategory = "".obs;
  RxString validateSousCatgory = "".obs;
  RxString validateMarque = "".obs;
  RxString validatePiece = "".obs;
  RxString validateModele = "".obs;
  RxString validateEnergie = "".obs;
  RxString validateYears = "".obs;
  RxString validateKm = "".obs;
  bool lights = true;
  bool isButtonSheet = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final storge = Get.find<SecureStorage>();
  final accountInfoStorage = Get.find<AccountInfoStorage>();
  final picker = ImagePicker();
  Validator validator = Validator();
  bool dataAdverts = false;
  bool dataEditFromServer = false;
  ModifAdsJson modifAdsJson = ModifAdsJson();
  CategoryGroupedJson category;
  SubcategoryJson subCategories;

  BuildContext context;
  RefJson energie;
  Map<String, dynamic> myAds = {};
  Map<String, String> myAdsView = {};
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController prix = TextEditingController();
  TextEditingController surface = TextEditingController();
  ModifAdsApi _modifAdsApi = ModifAdsApi();
  List<File> images = [];
  List<String> editAdsImages = [];
  List<RefJson> values = [
    RefJson(name: "Offre", id: 1),
    RefJson(name: "Demande", id: 2),
    RefJson(name: "Offre de location", id: 3)
  ];
  RefJson advertType;
  RefJson yearsModele;
  RefJson getView;
  RefJson vehiculebrands;
  RefJson motosBrand;
  RefJson vehiculeModel;
  RefJson citie;
  RefJson town;
  RefJson kilometrage;
  RefJson nombrePiece;
  List<RefJson> vehiculeBrands = [];
  List<RefJson> energies = [];
  List<RefJson> motosBrands = [];
  List<RefJson> vehiculeModels = [];
  List<RefJson> mileages = [];
  List<RefJson> yearsModels = [];
  List<RefJson> nombrePieces = [];
  List<String> photos = [];
  VehicleBrandsApi _vehicleBrandsApi = VehicleBrandsApi();
  MotoBrandsApi _motoBrandsApi = MotoBrandsApi();
  VehicleModelApi _vehicleModelApi = VehicleModelApi();
  MileagesApi _mileagesApi = MileagesApi();
  YearsModelsApi _yearsModelsApi = YearsModelsApi();
  EnergieApi _energieApi = EnergieApi();
  ValidateServer _validateServer = ValidateServer();
  RoomsNumberApi _roomsNumberApi = RoomsNumberApi();

  photobase64Encode(im) {
    final bytes = File(im.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    photos.add(img64);
  }

  void openCamera() async {
    var imgCamera = await picker.pickImage(source: ImageSource.camera);
    if (imgCamera != null) {
      images.add(File(imgCamera.path));
      update();
    }
    update();
  }

  void openGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));
      update();
    }
    update();
  }

  deleteImage(File file) {
    images.remove(file);
    update();
  }

  delEditImage(String file) {
    editAdsImages.remove(file);
    update();
  }

  updateCategoryToNull() {
    category = null;
    update();
  }

  updateSubcategoryToNull() {
    subCategories = null;
    update();
  }

  updateCategory(CategoryGroupedJson categoryGrouped) {
    category = categoryGrouped;
  }

  updateSubCategoryJson(SubcategoryJson subCategoryJson) {
    subCategories = subCategoryJson;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    advertType = values[0];
    myAds["advertType"] = values[0].name;
    myAdsView["advertType"] = values[0].name;

    if (Get.find<NetWorkController>().connectionStatus.value) {
      getMileages();
      getYearsModels();
    }
  }

  getEnergie() {
    energie = null;
    _energieApi.getList().then((value) {
      List<RefJson> refListJson = value.data;

      energies.clear();
      energies = refListJson;
      if (dataAdverts) {
        if (modifAdsJson.energy != null) {
          energies.forEach((element) {
            if (element.name == modifAdsJson.energy.value) {
              updateEnergie(element);
            }
          });
        }
      }
      update();
    });
  }

  Future getVehicleBrand() async {
    await _vehicleBrandsApi.getList().then((value) {
      vehiculeModel = null;

      vehiculeBrands = value.data;
      vehiculeBrands.forEach((element) {});

      update();
    });
  }

  getVehicleModel() {
    vehiculeModel = null;
    _vehicleModelApi.getList().then((value) {
      vehiculeModels = value.data;
      if (modifAdsJson.vehicleModel != null) {
        vehiculeModels.forEach((element) {
          if (element.name == modifAdsJson.vehicleModel.value) {
            updateModel(element);
          }
        });
      }
      getEnergie();
      update();
    });
  }

  getMileages() async {
    await _mileagesApi.getList().then((value) {
      mileages = value.data;
    });
    update();
  }

  getRoomsNumber() async {
    print("value");
    await _roomsNumberApi.getList().then((value) {
      print("value");
      print(value);
      nombrePieces = value.data;
    });
    update();
  }

  getMotosBrand() async {
    await _motoBrandsApi.getList().then((value) {
      motosBrands = value.data;
    });
  }

  getYearsModels() async {
    await _yearsModelsApi.getList().then((value) {
      yearsModels = value.data;
    });
    update();
  }

  updateGetView(RefJson data) async {
    getView = data;
    if (dataAdverts) {
    } else {
      vehiculebrands = null;
      vehiculeModel = null;
      motosBrand = null;
      yearsModele = null;
      kilometrage = null;
      if (Get.find<NetWorkController>().connectionStatus.value) {
        getVehicleBrand();
        getMotosBrand();
      }
    }
    update();
  }

  updateMarque(RefJson newValue) {
    _vehicleModelApi.vehicleModelId = newValue.id;
    myAds["vehicleBrand"] = newValue.id;
    myAdsView["Marque:"] = newValue.name;
    vehiculebrands = newValue;

    getVehicleModel();

    update();
  }

  updateMarqueMoto(RefJson newValue) {
    _vehicleModelApi.vehicleModelId = newValue.id;
    myAds["motoBrand"] = newValue.id;
    myAdsView["Marque:"] = newValue.name;
    motosBrand = newValue;

    update();
  }

  updateModel(RefJson newValue) {
    vehiculeModel = newValue;

    myAds["vehicleModel"] = newValue.id;
    myAdsView["Modèle:"] = newValue.name;
    update();
  }

  updateKilometrage(RefJson newValue) {
    kilometrage = newValue;

    myAds["mileage"] = newValue.id;
    myAdsView["Kilométrage:"] = newValue.name + " " + "Km";
    update();
  }

  updateAnnee(RefJson newValue) {
    yearsModele = newValue;
    myAds["yearModel"] = newValue.id;
    myAdsView["Année:"] = newValue.name;

    update();
  }

  updateEnergie(newValue) {
    energie = newValue;
    myAds["energy"] = newValue.id;
    myAdsView["energie:"] = newValue.name;

    update();
  }

  updateNombrePieces(newValue) {
    nombrePiece = newValue;
    myAds["roomsNumber"] = newValue.id;
    myAdsView["Nombre de pièces"] = newValue.name;
    print("Nombre de pièces");
    update();
  }

  updateLight(v) {
    lights = v;

    myAds["showPhoneNumber"] = v ? true : false;
    myAdsView["showPhoneNumber"] =
        v ? accountInfoStorage.readPhone() : accountInfoStorage.readPhone();
    update();
  }

  updateAdvertTypes(v) {
    values = v.data;
    advertType = values[0];
    myAds["advertType"] = advertType.id;
    myAdsView["advertType"] = advertType.name;
    update();
  }

  updateRadioButton(RefJson v) {
    advertType = v;

    myAds["advertType"] = v.id;
    myAdsView["advertType"] = v.name;
    update();
  }

  clearValidateOption() {
    validateTown.value = "";
    validateSousCatgory.value = "";
    validateCategory.value = "";
    validateCity.value = "";
    validateMarque.value = "";
    validateModele.value = "";
    validateEnergie.value = "";
    validateYears.value = "";
    validateKm.value = "";
    validatePiece.value = "";
  }

  clearAllData() {
    if (Get.find<NetWorkController>().connectionStatus.value) {
      RefJson refJson = RefJson(id: 0, name: "");
      updateGetView(refJson);
      Get.find<LocController>().city = null;
      Get.find<LocController>().town = null;
      Get.find<LocController>().update();
      Get.find<CategoryAndSubcategory>().categoryGroupedJson = null;
      Get.find<CategoryAndSubcategory>().subcategories1 = null;
      Get.find<CategoryAndSubcategory>().update();
      images.clear();
      photos.clear();
      editAdsImages.clear();
      dataAdverts = false;
      clearValidateOption();

      category = null;
      subCategories = null;
      town = null;
      citie = null;

      modifAds.value = false;
      yearsModele = null;
      vehiculebrands = null;
      motosBrand = null;
      vehiculeModel = null;
      energie = null;
      kilometrage = null;
      nombrePiece = null;

      myAds = {};
      myAdsView = {};
      title.text = "";
      description.text = "";
      prix.text = "";
      surface.text = "";

      update();
    }
  }

  postData(con) async {
    buttonPublier.value = true;
    for (var i in images) {
      photobase64Encode(i);
    }
    myAds["photos"] = photos;
    PublishApi publishApi = PublishApi();

    if (dataAdverts) {
      _modifAdsApi.id = modifAdsJson.id;
      await _modifAdsApi.putData(dataToPost: myAds).then((value) async {
        buttonPublier.value = false;

        if (value.statusCode == 204) {
          Get.find<TapMyadsViewController>().ads();
          Filter.data.clear();
          clearAllData();
          Get.find<CategoryAndSubcategory>().clearDataCategroyAndSubCategory();
          Get.find<LocController>().clearDataCityAndTown();
          Get.find<HomeViwController>().changeItemFilter(1);
          await showDialog<bool>(
              context: context,
              builder: (context) {
                return CustomDialogueFelecitation(
                  text2: " ",
                  title: "Félicitation",
                  function: () {
                    int i = 0;
                    while (i < 2) {
                      Navigator.pop(con);
                      i++;
                    }
                    Navigator.pop(context);
                    Get.find<TapMyadsViewController>().ads();
                    Get.find<TapPublishViewController>().clearAllData();
                    Get.find<HomeViwController>().changeItemFilter(1);
                    update();
                  },
                  description: "Votre annonce est en cours de validation !",
                  buttonText: "Ok",
                  phone: false,
                );
              });
        }
      });
    } else {
      devlog.log(jsonEncode(myAds));

      await publishApi.securePost(dataToPost: myAds).then((value) {
        buttonPublier.value = false;
        _validateServer.validatorServer(
            validate: () async {
              Filter.data.clear();
              clearAllData();
              Get.find<CategoryAndSubcategory>().subcategories1 = null;
              Get.find<CategoryAndSubcategory>().getCategoryGrouppedApi();
              Get.find<LocController>().getCitylist();
              await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return CustomDialogueFelecitation(
                      text2: " ",
                      title: "Félicitation",
                      function: () {
                        int i = 0;
                        while (i < 2) {
                          Navigator.pop(con);
                          i++;
                        }
                        Navigator.pop(context);
                        Get.find<TapPublishViewController>().clearAllData();
                        Get.find<TapMyadsViewController>().ads();
                        Get.find<HomeViwController>().changeItemFilter(1);
                      },
                      description: "Votre annonce est en cours de validation !",
                      buttonText: "Ok",
                      phone: false,
                    );
                  });
            },
            value: value);
      });
    }

    update();
  }

  getAllData(int id) async {
    _modifAdsApi.id = id;
    await _modifAdsApi.getList().then((value) async {
      modifAdsJson = value;
      print(value.toJson());
      title.text = modifAdsJson.title;
      description.text = modifAdsJson.description;
      prix.text = modifAdsJson.price.toString();
      lights = modifAdsJson.showPhoneNumber == true ? true : false;
      for (int cat = 0;
          cat < Get.find<CategoryAndSubcategory>().categoryGroupList.length;
          cat++) {
        if (Get.find<CategoryAndSubcategory>().categoryGroupList[cat].id ==
            modifAdsJson.category.group.id) {
          Get.find<CategoryAndSubcategory>().updateCategory(
              Get.find<CategoryAndSubcategory>().categoryGroupList[cat]);

          category = Get.find<CategoryAndSubcategory>().categoryGroupList[cat];

          for (int sub = 0;
              sub <
                  Get.find<CategoryAndSubcategory>()
                      .sc[modifAdsJson.category.group.id]
                      .length;
              sub++) {
            print(Get.find<CategoryAndSubcategory>()
                    .sc[modifAdsJson.category.group.id][sub]
                    .id ==
                modifAdsJson.category.id);
            print(Get.find<CategoryAndSubcategory>()
                .sc[modifAdsJson.category.group.id][sub]
                .id);
            print(modifAdsJson.category.id);

            if (Get.find<CategoryAndSubcategory>()
                    .sc[modifAdsJson.category.group.id][sub]
                    .id ==
                modifAdsJson.category.id) {
              updateSubCategoryJson(Get.find<CategoryAndSubcategory>()
                  .sc[modifAdsJson.category.group.id][sub]);
              Get.find<CategoryAndSubcategory>().updateSubCategory(
                  Get.find<CategoryAndSubcategory>()
                      .sc[modifAdsJson.category.group.id][sub]);
            }
          }
        }
      }
      for (int i = 0; i < Get.find<LocController>().cities.length; i++) {
        if (Get.find<LocController>().cities[i].id ==
            modifAdsJson.city.toJson()["id"]) {
          Get.find<LocController>().city = Get.find<LocController>().cities[i];
          citie = Get.find<LocController>().cities[i];
          myAds["city"] = Get.find<LocController>().cities[i].id;
          myAdsView["city"] = Get.find<LocController>().cities[i].name;
          Get.find<LocController>()
              .updateTowns(Get.find<LocController>().cities[i].id)
              .then((value) {
            for (int i = 0; i < Get.find<LocController>().towns.length; i++) {
              if (Get.find<LocController>().towns[i].id ==
                  modifAdsJson.town.toJson()["id"]) {
                Get.find<LocController>()
                    .updateTown(Get.find<LocController>().towns[i]);
                town = Get.find<LocController>().towns[i];
              }
            }
          });
        }
      }
      if (modifAdsJson.motoBrand != null) {
        await getMotosBrand();

        for (int i = 0; i < motosBrands.length; i++) {
          if (motosBrands[i].name == modifAdsJson.motoBrand.value) {
            motosBrand = null;
            updateMarqueMoto(motosBrands[i]);
          }
        }
      }
      if (modifAdsJson.vehicleBrand != null) {
        await getVehicleBrand();

        for (int i = 0; i < vehiculeBrands.length; i++) {
          if (vehiculeBrands[i].name == modifAdsJson.vehicleBrand.value) {
            vehiculebrands = null;
            updateMarque(vehiculeBrands[i]);
          }
        }
      }
      if (modifAdsJson.mileage != null) {
        mileages.forEach((element) {
          if (element.name == modifAdsJson.mileage.value) {
            updateKilometrage(element);
          }
        });
      }

      if (modifAdsJson.motoBrand != null) {
        for (int i = 0; i < motosBrands.length; i++) {
          if (motosBrands[i].name == modifAdsJson.motoBrand.value) {
            updateMarqueMoto(motosBrands[i]);
          }
        }
      }
      if (modifAdsJson.yearModel != null) {
        for (int i = 0; i < yearsModels.length; i++) {
          if (yearsModels[i].name == modifAdsJson.yearModel.value) {
            updateAnnee(yearsModels[i]);
          }
        }
      }
      if (modifAdsJson.roomsNumber != null) {
        for (int i = 0; i < nombrePieces.length; i++) {
          if (nombrePieces[i].id.toString() == modifAdsJson.roomsNumber.value) {
            updateNombrePieces(nombrePieces[i]);
          }
        }
      }
      surface.text = modifAdsJson.area.toString();

      editAdsImages.clear();
      modifAdsJson.photos.forEach((element) {
        editAdsImages.add(element.path);
      });
    });
  }
}
