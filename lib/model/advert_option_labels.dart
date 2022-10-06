import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdvertOptionLabels {
  static const Map<String, dynamic> optionsIds = {
    'mileage': {'label': 'Kilométrage', 'icon': FontAwesomeIcons.gauge},
    'year_model': {'label': 'Année/Modèle', 'icon': FontAwesomeIcons.calendarDays},
    'energy': {'label': 'Energie', 'icon': FontAwesomeIcons.gasPump},
    'vehicle_brand': {'label': 'Marque', 'icon': FontAwesomeIcons.tag},
    'vehicle_model': {'label': 'Modèle', 'icon': FontAwesomeIcons.car},
    'moto_brand': {'label': 'Marque', 'icon': FontAwesomeIcons.tag},
    'rooms_number': {
      'label': 'Nombre de pièces',
      'icon': Icons.grid_on_outlined
    },
    'area': {'label': 'Superficie', 'icon':Icons.border_outer_sharp},
  };
}
