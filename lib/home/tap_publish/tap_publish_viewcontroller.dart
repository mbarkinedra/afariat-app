import 'dart:io';
import 'dart:developer' as devlog;
import 'dart:convert';
import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/filter.dart';

import 'package:afariat/config/storage.dart';

import 'package:afariat/controllers/category_and_subcategory.dart';
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
  bool buttonPublier = false;
  bool buttonModif = false;
  bool buttonSupprimer = false;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final storge = Get.find<SecureStorage>();
  final accountInfoStorage = Get.find<AccountInfoStorage>();
  final picker = ImagePicker();

  Validator validator = Validator();
  bool dataAdverts = false;
  ModifAdsJson modifAdsJson = ModifAdsJson();
  CategoryGroupedJson category;
  SubcategoryJson subCategories;
  bool lights = true;
  String pieces;
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

  List<Widget> radioList = [];
  List<RefJson> values = [
    RefJson(name: "Offer", id: 1),
    RefJson(name: "Demande", id: 2),
    RefJson(name: "Offre de location", id: 3)
  ];

  List<RefJson> vehiculeBrands = [];
  List<RefJson> energies = [];

  List<RefJson> motosBrands = [];
  List<RefJson> vehiculeModels = [];
  List<RefJson> mileages = [];
  List<RefJson> yearsModels = [];
  List<RefJson> rooms = [];
  List<String> nombrePieces = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '10+'
  ];
  List<String> photos = [];

  // List<String> energies = ['Diesel', 'Essence', 'Electrique', 'LPG'];
  RefJson advertType;
  RefJson yearsmodele;
  RefJson getView;
  RefJson vehiculebrands;
  RefJson motosBrand;
  RefJson vehiculeModel;
  RefJson citie;
  RefJson town;
  RefJson kilometrage;

  VehicleBrandsApi _vehicleBrandsApi = VehicleBrandsApi();
  MotoBrandsApi _motoBrandsApi = MotoBrandsApi();
  VehicleModelApi _vehicleModelApi = VehicleModelApi();
  MileagesApi _mileagesApi = MileagesApi();
  YearsModelsApi _yearsModelsApi = YearsModelsApi();
  EnergieApi _energieApi = EnergieApi();
  ValidateServer _validateServer = ValidateServer();

  photobase64Encode(im) {
    final bytes = File(im.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    photos.add(img64);
  }

  void openCamera() async {
    var imgCamera = await picker.getImage(source: ImageSource.camera);

    if (imgCamera != null) {
      print(' image selected.');
      images.add(File(imgCamera.path));
      update();
    }

    update();
  }

  void openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print(' image selected.');
      images.add(File(pickedFile.path));
      update();
    }

    update();
  }

  deleteImage(File file) {
    images.remove(file);
    update();
  }

  deleditImage(String file) {
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
  void onInit() {
    super.onInit();
    advertType = values[0];
    myAds["advertType"] = values[0].name;
    myAdsView["advertType"] = values[0].name;
    getMileages();
    getYearsModels();
  }

  getEnergie() {
    energie = null;
    _energieApi.getList().then((value) {
      /*  print("eniytytyutytytytuytyutytutuyergy${value.data}");
      print("eniytytyutytytytuytyutytutuyergy${value}");*/
      List<RefJson> refListJson = value.data;
      energies.clear();
      energies = refListJson;

      update();
    });
  }

  getVehicleBrand() {
    _vehicleBrandsApi.getList().then((value) {
      vehiculeModel = null;

      vehiculeBrands = value.data;

      update();
    });
  }

  getVehicleModel() {
    _vehicleModelApi.getList().then((value) {
      vehiculeModels = value.data;
      getEnergie();
      update();
    });
  }

  getMileages() {
    _mileagesApi.getList().then((value) {
      mileages = value.data;

      update();
    });
  }

  getMotosBrand() {
    getMileages();
    getYearsModels();
    _motoBrandsApi.getList().then((value) {
      motosBrands = value.data;

      update();
    });
  }

  getYearsModels() {
    _yearsModelsApi.getList().then((value) {
      yearsModels = value.data;

      update();
    });
  }

  updateGetView(RefJson data) async {
    getView = data;
    vehiculebrands = null;
    vehiculeModel = null;
    motosBrand = null;
    yearsmodele = null;
    kilometrage = null;
    getVehicleBrand();
    getMotosBrand();

    update();
  }

  updateModel(RefJson newValue) {
    vehiculeModel = newValue;
    myAds["vehicleModel"] = newValue.id;
    myAdsView["Modèle:"] = newValue.name;
    update();
  }

  updateEnergie(newValue) {
    energie = newValue;
    myAds["energy"] = newValue.id;
    myAdsView["energie:"] = newValue.name;
    // getEnergie();
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

    getVehicleModel();
    update();
  }
  updateKilometrage(RefJson newValue) {
    kilometrage = newValue;

    myAds["mileage"] = newValue.id;
    myAdsView["Kilométrage:"] = newValue.name;
    update();
  }

  updateAnnee(RefJson newValue) {
    yearsmodele = newValue;
    myAds["yearModel"] = newValue.id;
    myAdsView["Année:"] = newValue.name;

    update();
  }

  updateNombredepieces(newValue) {
    pieces = newValue;
    myAds["roomsNumber"] = newValue;
    myAdsView["roomsNumber"] = newValue;
    update();
  }

  updateLight(v) {
    lights = v;
    print(accountInfoStorage.readPhone());

    myAds["showPhoneNumber"] = v ? true:false;
    myAdsView["showPhoneNumber"] =
        v ? accountInfoStorage.readPhone() : accountInfoStorage.readPhone();
    update();
  }

  updateadvertTypes(v) {
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

  clearAllData() {
    category = null;
    subCategories = null;
    yearsmodele = null;
    getView = null;
    vehiculebrands = null;
    motosBrand = null;
    vehiculeModel = null;
    energie = null;
    kilometrage = null;
    pieces = null;
    town = null;
    citie = null;

    myAds = {};
    myAdsView = {};
    title.text = "";
    description.text = "";
    prix.text = "";
    surface.text = "";

    update();
  }

  postdata() async {
    buttonPublier = true;
    update();
    for (var i in images) {
      photobase64Encode(i);
    }
    myAds["photos"] = photos;
    print(photos.length);
    PublishApi publishApi = PublishApi();

    if (dataAdverts) {
      _modifAdsApi.id = modifAdsJson.id;
      await _modifAdsApi.putData(dataToPost: myAds).then((value) async {
        if (value.statusCode == 204) {
          await showDialog<bool>(
              context: context,
              builder: (context) {
                return CustomDialogueFelecitation(
                  text2: " ",
                  title: "Félicitation",
                  function: () {
                    Get.find<TapMyadsViewController>().ads();
                    Get.find<HomeViwController>().changeSelectedValue(1);
                    Filter.data.clear();
                    clearAllData();
                    Get.find<CategoryAndSubcategory>().clearData();
                    Get.find<LocController>().clearData();

                    buttonPublier = false;
                    Navigator.pop(context);
                    update();
                    // Get.back();
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
        _validateServer.validatorServer(
            validate: () async {
              await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return CustomDialogueFelecitation(
                      text2: " ",
                      title: "Félicitation",
                      function: () {

                        Filter.data.clear();
                        clearAllData();
                        Get.find<CategoryAndSubcategory>().clearData();
                        Get.find<LocController>().clearData();

                   for (int ii = 0; ii < 2; ii++) {

                          Get.back();
                        }


                        Get.find<TapMyadsViewController>().ads();

                        Get.find<HomeViwController>().changeSelectedValue(1);
                        //  Navigator.pop(context);
                        update();
                      },
                      description: "Votre annonce est en cours de validation !",
                      buttonText: "Ok",
                      phone: false,
                    );
                  });
            },
            value: value);

        buttonPublier = false;

        update();
      });
    }

    update();
  }

  getModifAds(int id) {
    _modifAdsApi.id = id;

    _modifAdsApi.getList().then((value) {
      modifAdsJson = value;
      title.text = modifAdsJson.title;
      description.text = modifAdsJson.description;
      prix.text = modifAdsJson.price.toString();
      lights = modifAdsJson.showPhoneNumber == true? true : false;
      for (int i = 0; i < Get.find<LocController>().cities.length; i++) {
        if (Get.find<LocController>().cities[i].id ==
            modifAdsJson.city.toJson()["id"]) {
          Get.find<LocController>().city = Get.find<LocController>().cities[i];
          Get.find<LocController>()
              .updateCity(Get.find<LocController>().cities[i]);
          Get.find<LocController>()
              .updateTowns(Get.find<LocController>().cities[i].id)
              .then((value) {
            for (int i = 0; i < Get.find<LocController>().towns.length; i++) {
              if (Get.find<LocController>().towns[i].id ==
                  modifAdsJson.town.toJson()["id"]) {
                Get.find<LocController>()
                    .updateTown(Get.find<LocController>().towns[i]);
              }
            }
          });
        }
      }

      for (int category = 0;
          category <
              Get.find<CategoryAndSubcategory>().categoryGroupList.length;
          category++) {
        if (Get.find<CategoryAndSubcategory>().categoryGroupList[category].id ==
            modifAdsJson.category.group.id) {
          Get.find<CategoryAndSubcategory>().updateCategory(
              Get.find<CategoryAndSubcategory>().categoryGroupList[category]);
          SubcategoryJson subcat = Get.find<CategoryAndSubcategory>()
              .sc[modifAdsJson.category.group.id]
              .where((element) => element.id == modifAdsJson.category.id)
              .first;
          updateSubCategoryJson(subcat);
          Get.find<CategoryAndSubcategory>().updateSubCategory(subcat);
          print(subcat.toString());
        }
      }
      editAdsImages
          .clear(); // categoryAndSubcategory.updateSupCategorie(subcat );
      modifAdsJson.photos.forEach((element) {
        print(element.path);
        editAdsImages.add(element.path);
      });
      update();
    });
  }
}
