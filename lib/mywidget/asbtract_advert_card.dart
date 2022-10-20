import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../config/Environment.dart';
import '../networking/json/advert_minimal_json.dart';

abstract class AbstractAdvertCard extends StatelessWidget {
  final AdvertMinimalJson advert;
  final numberFormat = NumberFormat("###,##0", Environment.locale);
  final String userInitials;
  final double imageHeight;
  final double imageWidth;

  AbstractAdvertCard({Key key, this.advert, this.userInitials, this.imageHeight, this.imageWidth}) : super(key: key);
}
