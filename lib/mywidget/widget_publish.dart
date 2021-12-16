import 'package:afariat/publish_ads_model/motos.dart';
import 'package:afariat/publish_ads_model/rooms.dart';
import 'package:afariat/publish_ads_model/vehicle-brands.dart';
import 'package:flutter/material.dart';

class WidgetPublish extends StatelessWidget {
  String cat;

  WidgetPublish(this.cat);

  @override
  Widget build(BuildContext context) {
    switch (cat) {
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
