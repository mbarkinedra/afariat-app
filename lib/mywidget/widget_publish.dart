import 'package:afariat/home/tap_publish/publish_ads_model/motos.dart';
import 'package:afariat/home/tap_publish/publish_ads_model/rooms.dart';
import 'package:afariat/home/tap_publish/publish_ads_model/vehicle-brands.dart';

import 'package:flutter/material.dart';

class WidgetPublish extends StatelessWidget {
  String categorie;

  WidgetPublish(this.categorie);

  @override
  Widget build(BuildContext context) {
    print("bbbbbbbbbbbbbbbbbbbbb  $categorie");
    switch (categorie) {
      case "Voitures":
        {
          return VehicleBrands();
        }
        break;

      case "Voitures professionnelles":
        {
          return VehicleBrands();
        }
        break;

      case "Motos":
        {
          return Motos();
        }
        break;
      case "Appartements":
        {
          return Rooms();
        }
        break;

      case "Maison":
        {
          return Rooms();
        }
        break;

      case "Bureaux et locaux commerciaux":
        {
          return Rooms();
        }
        break;

      default:
        {
          return Container();
        }
        break;
    }
  }
}
