import 'package:afariat/config/filter.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/advert_details_json.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TapPublishViewController extends GetxController {
  final categoryAndSubcategory = Get.find<CategoryAndSubcategory>();

  // final locController = Get.find<LocController>();

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
  String advertType ;
  List<RefJson> vehiculeBrands = [];
  List<RefJson> motosBrands = [];
  List<RefJson> vehiculeModels = [];
  List<RefJson> meliages = [];
  List<RefJson> yersmodeles = [];
  RefJson yersmodele;
  RefJson getview;
  RefJson vehiculebrands;
   RefJson  motosBrand;
  RefJson vehiculeModel;
  String energie;
  RefJson kelometrage;
  VehicleBrandsApi _vehicleBrandsApi = VehicleBrandsApi();
  MotoBrandsApi _motoBrandsApi = MotoBrandsApi();
  VehicleModelApi _vehicleModelApi = VehicleModelApi();
  MileagesApi _mileagesApi = MileagesApi();
  YearsModelsApi _yearsModelsApi = YearsModelsApi();
  List<RefJson> rooms = [];

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

  @override
  void onInit() {
    super.onInit();
    advertType=valus[0].name;
    getmeliages();
    getyearsmodels();
  }

  getvehicleBrand() {

    _vehicleBrandsApi.getList().then((value) {

      vehiculeModel=null;

      vehiculeBrands = value.data;
        
      update();
    });
  }

  getvehicleModel() {
    _vehicleModelApi.getList().then((value) {
      vehiculeModels = value.data;
Filter.Id=null;
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
    vehiculebrands= null;
    vehiculeModel = null;
    motosBrand= null;
    yersmodele= null;
    kelometrage= null;
    getvehicleBrand();
   getMotosBrand();
    //  getvehicleModel();
   // getmeliages();
    update();
  }

  updateModele(RefJson newValue) {
    vehiculeModel = newValue;
    update();
  }

  updateEnergie(newValue) {
    energie = newValue;
    update();
  }

  updateMarque(RefJson newValue) {


    Filter.Id = newValue.id.toString();
    vehiculebrands = newValue;

    //getvehicleBrand();
    getvehicleModel();
    update();
  }

  updateKilomtrage(RefJson newValue) {
    kelometrage = newValue;
    //getmeliages();
    update();
  }

  updateAnnee(RefJson newValue) {
    yersmodele = newValue;
    //getyearsmodels();
    update();
  }

  updateNombredepieces(newValue) {
    pieces = newValue;

    update();
  }

  // void init () {
  //
  //   .mileages().then((value) {
  //     meliages = value.data;
  //
  //     print(value.data);
  //   });
  //   _publishAPIs.yearmodels().then((value) {
  //     yersmodeles = value.data;
  //     setState(() {});
  //     print(value.data);
  //   });
  //   super.initState();
  // }

  updateLight(v) {
    lights = v;
    update();
  }

  updateadvertTypes(v) {
    valus = v.data;
    advertType=valus[0].name;
    update();
  }

  updateRadioButton(v) {
    advertType = v;
    update();
  }
}
