import 'dart:io';
import 'dart:developer' as devlog;
import 'dart:convert';
import 'package:afariat/networking/api/advert_api.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/storage/storage.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_myads/myads_view_controller.dart';
import 'package:afariat/validator/validator_Adverts.dart';
import 'package:afariat/mywidget/custom_dialogue_felecitation.dart';
import 'package:afariat/networking/api/modif_ads_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:afariat/networking/json/modif_ads_json.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../networking/network.dart';
import '../main_view_controller.dart';

class TapPublishViewController extends GetxController {
  //if set to true, when update categories, options,... the filter will be set by the selected value.
  bool isFilterContext = false;
  RxBool buttonPublier = false.obs;
  int newPublish = 0;
  RxBool modifAds = false.obs;
  bool getDataFromServer = false;
  bool lights = true;
  bool isButtonSheet = false;
  GlobalKey<FormState> formKey;
  final storge = Get.find<SecureStorage>();
  final accountInfoStorage = Get.find<AccountInfoStorage>();
  final picker = ImagePicker();
  ValidatorAdverts validator = ValidatorAdverts();
  bool dataAdverts = false;
  bool dataEditFromServer = false;
  ModifAdsJson modifAdsJson = ModifAdsJson();
  CategoryGroupedJson category;
  SubCategoryJson subCategories;
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
  RoomsNumberApi _roomsNumberApi = RoomsNumberApi();
  AdvertApi _advertApi = AdvertApi();

  /// Convert image to base64
  photoBase64Encode(im) {
    final bytes = File(im.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    photos.add(img64);
  }

  /// Open Camera from Emelator
  void openCamera() async {
    var imgCamera = await picker.pickImage(source: ImageSource.camera);
    if (imgCamera != null) {
      images.add(File(imgCamera.path));
      update();
    }
    update();
  }

  /// Open Camera from Emelator

  void openGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));
      update();
    }
    update();
  }

  /// Delete Image from local
  deleteImage(File file) {
    images.remove(file);
    update();
  }

  /// Delete image (lors de modifier l annonce )
  delEditImage(String file) {
    editAdsImages.remove(file);
    update();
  }

  ///Clear category in publishController
  updateCategoryToNull() {
    category = null;
    update();
  }

  ///Clear SubCategory in publishController
  updateSubcategoryToNull() {
    subCategories = null;
    update();
  }

  updateCategory(CategoryGroupedJson categoryGrouped) {
    category = categoryGrouped;
  }

  updateSubCategoryJson(SubCategoryJson subCategoryJson) {
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

    if (Network.status.value) {
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
          for (var element in energies) {
            if (element.name == modifAdsJson.energy.value) {
              updateEnergie(element);
            }
          }
        }
      }
      update();
    });
  }

  /// Update dropDown Marque
  Future getVehicleBrand() async {
    await _vehicleBrandsApi.getList().then((value) {
      vehiculeModel = null;
      vehiculeBrands = value.data;
      update();
    });
  }

  getVehicleModel() {
    vehiculeModel = null;
    _vehicleModelApi.getList().then((value) {
      vehiculeModels = value.data;
      if (modifAdsJson.vehicleModel != null) {
        for (var element in vehiculeModels) {
          if (element.name == modifAdsJson.vehicleModel.value) {
            updateModel(element);
          }
        }
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
    await _roomsNumberApi.getList().then((value) {
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
      if (Network.status.value) {
        getVehicleBrand();
        getMotosBrand();
      }
    }
    update();
  }

  /// Update value of dropDown Marque
  updateMarque(RefJson newValue) {
    _vehicleModelApi.vehicleModelId = newValue.id;
    myAds["vehicleBrand"] = newValue.id;
    myAdsView["Marque:"] = newValue.name;
    vehiculebrands = newValue;
    //set filter if we are in context filter
    if (isFilterContext == true) {
      Filter.set("vehicleBrand", newValue.id);
    }
    getVehicleModel();

    update();
  }

  updateMarqueMoto(RefJson newValue) {
    _vehicleModelApi.vehicleModelId = newValue.id;
    myAds["motoBrand"] = newValue.id;
    myAdsView["Marque:"] = newValue.name;
    motosBrand = newValue;

    //set filter if we are in context filter
    if (isFilterContext == true) {
      Filter.set( "motoBrand",  newValue.id);
    }

    update();
  }

  updateModel(RefJson newValue) {
    vehiculeModel = newValue;

    myAds["vehicleModel"] = newValue.id;
    myAdsView["Modèle:"] = newValue.name;

    //set filter if we are in context filter
    if (isFilterContext == true) {
      Filter.set("vehicleModel",  newValue.id);
    }

    update();
  }

  updateKilometrage(RefJson newValue) {
    kilometrage = newValue;

    myAds["mileage"] = newValue.id;
    myAdsView["Kilométrage:"] = newValue.name + " " + "Km";

    //set filter if we are in context filter
    if (isFilterContext == true) {
      Filter.set("mileage",  newValue.id);
    }

    update();
  }

  updateAnnee(RefJson newValue) {
    yearsModele = newValue;
    myAds["yearModel"] = newValue.id;
    myAdsView["Année:"] = newValue.name;

    //set filter if we are in context filter
    if (isFilterContext == true) {
      Filter.set("yearModel",  newValue.id);
    }

    update();
  }

  updateEnergie(newValue) {
    energie = newValue;
    myAds["energy"] = newValue.id;
    myAdsView["energie:"] = newValue.firstName;

    //set filter if we are in context filter
    if (isFilterContext == true) {
      Filter.set("energy",  newValue.id);
    }

    update();
  }

  updateNombrePieces(newValue) {
    nombrePiece = newValue;
    myAds["roomsNumber"] = newValue.id;
    myAdsView["Nombre de pièces"] = newValue.firstName;

    //set filter if we are in context filter
    if (isFilterContext == true) {
      Filter.set("roomsNumber",  newValue.id);
    }

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

  /// Clear All Data From Screen Publish
  clearAllData() {
    if (Network.status.value) {
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
      surface.clear();
      update();
    }
  }

  postData(con) async {
    buttonPublier.value = true;

    /// get all image selected and convert base64
    for (var i in images) {
      photoBase64Encode(i);
    }
    myAds["photos"] = photos;

    /// Method Modif Adverts
    if (dataAdverts) {
      _modifAdsApi.id = modifAdsJson.id;
      await _modifAdsApi.putData(dataToPost: myAds).then((value) async {
        buttonPublier.value = false;
        validator.validatorServer.validateServer(
            value: value,
            success: () async {
              Get.find<MyAdsViewController>().getAllAds();
              Filter.clear();
              clearAllData();
              Get.find<CategoryAndSubcategory>()
                  .clearDataCategroyAndSubCategory();
              Get.find<LocController>().clearDataCityAndTown();
              //Get.find<MainViewController>().changeItemFilter(1);
              await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return CustomDialogueFelecitation(
                      text2: " ",
                      title: "Félicitation",
                      function: () {
                        int i = 0;
                        while (i < 2) {
                          i++;
                        }
                        Navigator.pop(context);
                        Get.find<MyAdsViewController>().getAllAds();
                        Get.find<TapPublishViewController>().clearAllData();
                       // Get.find<MainViewController>().changeItemFilter(1);
                      },
                      description: "Votre annonce est en cours de validation !",
                      buttonText: "Ok",
                      phone: false,
                    );
                  });
            });
        update();
      });
    } else {
      devlog.log(jsonEncode(myAds));

      /// Method Post Adverts
      await _advertApi.postResource(dataToPost: myAds).then((value) {
        buttonPublier.value = false;
        validator.validatorServer.validateServer(
          value: value,
          success: () async {
            Filter.clear();
            clearAllData();
            Get.find<CategoryAndSubcategory>().subcategories1 = null;
            Get.find<CategoryAndSubcategory>().getCategoryGrouppedApi();
            Get.find<LocController>().getCityListSelected();
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
                      Get.find<MyAdsViewController>().getAllAds();
                     // Get.find<MainViewController>().changeItemFilter(1);
                    },
                    description: "Votre annonce est en cours de validation !",
                    buttonText: "Ok",
                    phone: false,
                  );
                });
          },
        );
      });
    }

    update();
  }

  /// Method Get all data for update Adverts
  getAllData(int id) async {
    _modifAdsApi.id = id;
    await _modifAdsApi.getList().then((value) async {
      modifAdsJson = value;
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
              .getTowListSelected(Get.find<LocController>().cities[i].id)
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
        for (var element in mileages) {
          if (element.name == modifAdsJson.mileage.value) {
            updateKilometrage(element);
          }
        }
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
      if (modifAdsJson.area != null) {
        surface.text = modifAdsJson.area.toString();
      }

      editAdsImages.clear();
      for (var element in modifAdsJson.photos) {
        editAdsImages.add(element.path);
      }
    });
  }

  Future<bool> function() async {
    return true;
  }

  loadTapPublish(value) {
    if (value != 2 || newPublish >= 2) {
      newPublish = 1;
      Get.find<CategoryAndSubcategory>().getCategoryGrouppedApi();
      Get.find<LocController>().getCityListSelected();
      clearAllData();
    } else if (!modifAds.value) {
      newPublish = 1;
      Get.find<LocController>().getCityListSelected();
      Get.find<CategoryAndSubcategory>().getCategoryGrouppedApi();
      clearAllData();
    } else {
      newPublish++;
    }
  }

  /// Method Default Options
  void defaultOptions() {
    if (formKey.currentState.validate()) {
      myAdsView["prix"] = prix.text;
      myAds["price"] = prix.text;
      myAdsView["title"] = title.text;
      myAds["title"] = title.text;
      myAdsView["description"] = description.text;
      myAds["description"] = description.text;

      if (surface.text.isNotEmpty) {
        myAds["area"] = surface.text;
        myAdsView["Superficie"] = surface.text;
      }
      myAds["showPhoneNumber"] = lights ? "yes" : "no";
      myAdsView["showPhoneNumber"] = lights ? "Check" : "no";
    } else {
      Get.snackbar("Oups !", "Merci de corriger les erreurs ci-dessous.");
    }
  }
}
