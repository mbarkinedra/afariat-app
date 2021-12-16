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
  final locController = Get.find<LocController>();

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  bool lights = false;
  List<Widget> radiolist = [];
  List<RefJson> valus = [
    RefJson(name: "Offer", id: 1),
    RefJson(name: "Demande", id: 2),
    RefJson(name: "Offre de location", id: 3)
  ];
  String advertType;



  List<RefJson> motosBrands = [];
  List<RefJson> vehiculeModels = [];
  List<RefJson> meliages = [];
  List<RefJson> yersmodeles = [];
  RefJson yersmodele;
  RefJson meliage;
  RefJson dropdownValue;
  RefJson vehiculeModel;
  String energie;
  VehicleBrandsApi _vehicleBrandsApi=VehicleBrandsApi();
  List<RefJson> rooms = [];

  String pieces;
  List<String>Nombredepices=[ '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '10+'];


  List<String>energies=['Diesel', 'Essence', 'Electrique', 'LPG'];
  List<RefJson> vehiculeBrands = [];
  // List<RefJson> vehiculeModels = [];
  // List<RefJson> meliages = [];
  // List<RefJson> yersmodeles = [];
  // RefJson yersmodele;
  // Data meliage;
  // Data dropdownValue;
  // Data vehiculeModel;
  // String energie;

  getvevehicleBrand(){

    _vehicleBrandsApi.getList().then((value) {
      motosBrands = value.data;

      print(value.data);
      update();
    });
  }
  updateModele(RefJson newValue) {
    vehiculeModel = newValue;
    update();
  }

  updateEnergie(  newValue) {
    energie = newValue;
    update();
  }
  updateMarque(RefJson newValue) {
    Filter.Id=newValue.id.toString();
    dropdownValue = newValue;
     vehiculeModel = null;
     getvevehicleBrand();
     update();
  }
  updateKilomtrage(RefJson newValue) {

    meliage = newValue;

    update();
  }
  updateAnnee(RefJson newValue) {

    yersmodele = newValue;

    update();
  }

  updateNombredepieces(  newValue) {

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
    update();
  }

  updateRadioButton(   v) {
    advertType = v;
    update();
  }
}
