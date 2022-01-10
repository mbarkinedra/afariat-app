import 'dart:io';

import 'dart:convert';
import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/config/wsse.dart';
import 'package:afariat/networking/api/get_salt_api.dart';

import 'package:afariat/networking/api/publish_api.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class TapPublishViewController extends GetxController {
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  CategoryGroupedJson category;
  SubcategoryJson subcategories;

  Map<String, dynamic> myAds = {};
  Map<String, String> myAdsview = {};
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController surface = TextEditingController();
  bool lights = false;

  //bool lights = false;
  List<Widget> radiolist = [];
  List<RefJson> valus = [
    RefJson(name: "Offer", id: 1),
    RefJson(name: "Demande", id: 2),
    RefJson(name: "Offre de location", id: 3)
  ];
  RefJson advertType;
  GetSaltApi _getSalt = GetSaltApi();
  List<RefJson> vehiculeBrands = [];
  List<RefJson> motosBrands = [];
  List<RefJson> vehiculeModels = [];
  List<RefJson> meliages = [];
  List<RefJson> yersmodeles = [];
  RefJson yearsmodele;
  RefJson getview;
  RefJson vehiculebrands;
  RefJson motosBrand;
  RefJson vehiculeModel;
  String energie;
  RefJson kilometrage;
  VehicleBrandsApi _vehicleBrandsApi = VehicleBrandsApi();
  MotoBrandsApi _motoBrandsApi = MotoBrandsApi();
  VehicleModelApi _vehicleModelApi = VehicleModelApi();
  MileagesApi _mileagesApi = MileagesApi();
  YearsModelsApi _yearsModelsApi = YearsModelsApi();
  List<RefJson> rooms = [];
  RefJson citie;
  final storge = Get.find<SecureStorage>();
  final accountInfoStorage = Get.find<AccountInfoStorage>();

  RefJson town;
  String pieces;
  List<String> Nombredepieces = [
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

  List<String> energies = ['Diesel', 'Essence', 'Electrique', 'LPG'];
  File image;
  File image2;
  List<String> photos = [];
  final picker = ImagePicker();

  photobase64Encode(im) {
    final bytes = File(im.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    photos.add(img64);
  }

  void openCamera(int i) async {
    var imgCamera = await picker.getImage(source: ImageSource.camera);
    if (i == 1) {
      image = File(imgCamera.path);
      update();
    } else {
      image2 = File(imgCamera.path);
      update();
    }
  }

  void openGallery(int i) async {
    //  final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (i == 1) {
      if (pickedFile != null) {
        print(' image selected.');
        image = File(pickedFile.path);
        update();
      } else {
        print('No image selected.');
      }
    } else {
      if (pickedFile != null) {
        print(' image selected.');
        image2 = File(pickedFile.path);
        update();
      } else {
        print('No image selected.');
      }
    }
  }

  updatecategoryToNull() {
    category = null;
    update();
  }

  updateSubcategoryToNull() {
    subcategories = null;
    update();
  }

  updatecategory(CategoryGroupedJson cat) {
    category = cat;
  }

  updateSubcategoryJson(SubcategoryJson sub) {
    subcategories = sub;
  }

  @override
  void onInit() {
    super.onInit();
    advertType = valus[0];
    myAds["advertType"] = valus[0].name;
    myAdsview["advertType"] = valus[0].name;
    getmeliages();
    getyearsmodels();
  }

  getvehicleBrand() {
    _vehicleBrandsApi.getList().then((value) {
      vehiculeModel = null;

      vehiculeBrands = value.data;

      update();
    });
  }

  getvehicleModel() {
    _vehicleModelApi.getList().then((value) {
      vehiculeModels = value.data;

      update();
    });
  }

  getmeliages() {
    _mileagesApi.getList().then((value) {
      meliages = value.data;

      update();
    });
  }

  getMotosBrand() {
    getmeliages();
    getyearsmodels();
    _motoBrandsApi.getList().then((value) {
      motosBrands = value.data;

      update();
    });
  }

  getyearsmodels() {
    _yearsModelsApi.getList().then((value) {
      yersmodeles = value.data;

      update();
    });
  }

  updategetview(RefJson data) async {
    getview = data;
    vehiculebrands = null;
    vehiculeModel = null;
    motosBrand = null;
    yearsmodele = null;
    kilometrage = null;
    getvehicleBrand();
    getMotosBrand();

    update();
  }

  updateModele(RefJson newValue) {
    vehiculeModel = newValue;
    myAds["vehicleModel"] = newValue.id;
    myAdsview["vehicleModel"] = newValue.name;
    update();
  }

  updateEnergie(newValue) {
    energie = newValue;
    update();
  }

  updateMarque(RefJson newValue) {
    _vehicleModelApi.vehicleModelId = newValue.id;
    myAds["vehiclebrand"] = newValue.id;
    myAdsview["vehiclebrand"] = newValue.name;
    vehiculebrands = newValue;

    getvehicleModel();
    update();
  }

  updateKilomtrage(RefJson newValue) {
    kilometrage = newValue;

    myAds["mileage"] = newValue.id;
    myAdsview["mileage"] = newValue.name;
    update();
  }

  updateAnnee(RefJson newValue) {
    yearsmodele = newValue;
    myAds["yearModel"] = newValue.id;
    myAdsview["yearModel"] = newValue.name;

    update();
  }

  updateNombredepieces(newValue) {
    pieces = newValue;
    myAds["roomsNumber"] = newValue;
    myAdsview["roomsNumber"] = newValue;
    update();
  }

  updateLight(v) {
    lights = v;
    myAds["showPhoneNumber"] = v ? "yes" : "no";
    myAdsview["showPhoneNumber"] = v ? "yes" : "no";
    update();
  }

  updateadvertTypes(v) {
    valus = v.data;
    advertType = valus[0];
    myAds["advertType"] = advertType.id;
    myAdsview["advertType"] = advertType.name;
    update();
  }

  updateRadioButton(RefJson v) {
    advertType = v;

    myAds["advertType"] = v.id;
    myAdsview["advertType"] = v.name;
    update();
  }

  postdata() async {
    if (image != null) {
      photobase64Encode(image);
    }
    if (image2 != null) {
      photobase64Encode(image2);
    }
    myAds["photos"] = photos;
    print(photos.length);
    PublishApi publishApi = PublishApi();

    // Map<String, dynamic> serverErrors;

    publishApi.securePost(dataToPost: myAds).then((value) {
      if (value.statusCode == 201) {
        Get.defaultDialog(
          title: "Felécitation",
          middleText: "Votre annonce a été  publiée avec succés!",
          confirm: GestureDetector(
            child: Text("ok"),
            onTap: () {
              Get.back();
            },
          ),
          titleStyle: TextStyle(color: Colors.deepOrange),
          middleTextStyle: TextStyle(color: Colors.deepOrange),
        );
      }
    });
    // var response = await http.post(url, body: jsonEncode(myAds),headers: {
    //
    //   "Accept": "application/json",
    //   'apikey': SettingsApp.apiKey,
    //   'Content-Type': 'application/json',
    // 'X-WSSE': wsse,
    // });

    //     print('Response status: ${vv.statusCode}');
    //    print('Response body: ${vv.data}');

    // switch (value.statusCode) {
    //   case 201:
    //     Get.snackbar(
    //       'hii',
    //       'gggggggggggggggg.',
    //       colorText: Colors.white,
    //       backgroundColor: Colors.red,
    //     );
    //
    //     break;
    //   case 400:
    //     serverErrors = value.data;
    //     value.data.forEach((key, value) {
    //       print('Key: $key');
    //       print('------------------------------');
    //     });
    //
    //
    //
    //     Get.snackbar(
    //       'Erreur',
    //       'Veuillez corriger les erreurs ci-dessous.',
    //       colorText: Colors.white,
    //       backgroundColor: Colors.red,
    //     );
    //     break;
    //   default:
    //     return;
    // }
    //

    //  print(vv.toString());
//    });
  }

  String validatetitle(String value) {
    if (value.length < 11 || value.contains(new RegExp(r'[0-9]'))) {
      return "Le titre doit être renseigné";
    }

    return null;
  }

  String validatePrice(String value) {
    if (value.length < 1) {
      return "Le prix n'est pas valide";
    }

    return null;
  }

  String validateDescription(String value) {
    if (value.length < 50) {
      return "La description doit faire au moins 50 caractères";
    }

    return null;
  }

  isvala() {
    final isv = globalKey.currentState.validate();
    print(isv);
  }
}
