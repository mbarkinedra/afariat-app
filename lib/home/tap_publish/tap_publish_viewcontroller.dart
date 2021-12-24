import 'dart:io';

import 'dart:convert';
import 'package:afariat/config/filter.dart';
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

class TapPublishViewController extends GetxController {
  CategoryGroupedJson category;
  SubcategoryJson subcategories;

  Map<String, dynamic> myAds = {};
  Map<String, String> myAdsview = {};
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController surface = TextEditingController();
  bool lights = false;
  List<Widget> radiolist = [];
  List<RefJson> valus = [
    RefJson(name: "Offer", id: 1),
    RefJson(name: "Demande", id: 2),
    RefJson(name: "Offre de location", id: 3)
  ];
  String advertType;
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
List<String >photos=[];
  final picker = ImagePicker();
photobase64Encode(im){
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

  updatecategory(CategoryGroupedJson cat) {
    category = cat;
  }

  updateSubcategoryJson(SubcategoryJson sub) {
    subcategories = sub;
  }

  @override
  void onInit() {
    super.onInit();
    advertType = valus[0].name;
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
      Filter.Id = null;
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
    //  getvehicleModel();
    // getmeliages();
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
    Filter.Id = newValue.id.toString();
    myAds["vehiclebrand"] = newValue.id;
    myAdsview["vehiclebrand"] = newValue.name;
    vehiculebrands = newValue;

    //getvehicleBrand();
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
    advertType = valus[0].name;
    update();
  }

  updateRadioButton(v) {
    advertType = v;

    myAds["advertType"] = v;
    myAdsview["advertType"] = v;
    update();
  }

  postdata() {
    print(" key_email    ${storge.readSecureData(storge.key_email)} ");
    if(image!=null){
      photobase64Encode(image);
    }
    if(image2!=null){
      photobase64Encode(image2);
    }

    _getSalt.post({"login": "${storge.readSecureData(storge.key_email)}"}).then(
        (value) {
      print(value.data);
      String hashedPassword = hashPassword(
          storge.readSecureData(storge.key_password), value.data["salt"]);
      String wsse = generateWsseHeader(
          storge.readSecureData(storge.key_email), hashedPassword);
      print(wsse);
      myAds["X-WSSE"] = wsse;
       myAds["photos"] =photos;
      print("44444444444444444444444444444444444444444444444444");
print(photos.length);
      print("44444444444444444444444444444444444444444444444444");
      PublishApi publishApi = PublishApi();

      publishApi.post(myAds).then((value) {
        print(value);
      });
    });

    /* AdvertModel advertModel = AdvertModel(
      //category:Get.find<CategoryAndSubcategory>().subcategories1 ,
      price: price.text,
      description: description.text,
      title: title.text,
      town: town.id,
      advertType: advertType,
      showPhoneNumber: lights ? "yes" : "no",
      city: citie.id,
      mileage: kelometrage.id ?? 0,
      motoBrand: 0,
      // motosBrand.id?? 0,
      roomsNumber: pieces ?? 0.toString(),
      vehicleModel: vehiculeModel.id ?? 0,
      vehicleBrand: vehiculebrands.id ?? 0,
      yearModel: yersmodele.id ?? 0,
    );*/
  }
}
