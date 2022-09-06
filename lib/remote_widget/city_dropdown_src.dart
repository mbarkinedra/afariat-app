import 'package:afariat/remote_widget/ref_dropdown_src.dart';
import 'package:flutter/src/foundation/key.dart';
import 'city_dropdown_viewcontroller.dart';

class CityDropdown extends RefDropdown<CityDropdownViewController> {
  CityDropdown(CityDropdownViewController viewController, {String label ,Function validator, Key key})
      : super(viewController, label, validator, key: key);
}
