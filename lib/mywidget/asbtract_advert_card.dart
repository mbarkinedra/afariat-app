import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../config/Environment.dart';
import '../networking/json/adverts_json.dart';

abstract class AbstractAdvertCard extends StatelessWidget {
  final AdvertJson advert;
  final numberFormat = NumberFormat("###,##0", Environment.locale);
  final String userInitials;

  AbstractAdvertCard({Key key, this.advert, this.userInitials}) : super(key: key);
}
