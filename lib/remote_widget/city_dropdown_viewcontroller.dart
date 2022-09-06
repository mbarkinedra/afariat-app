import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/remote_widget/ref_dropdown_viewcontroller.dart';

class CityDropdownViewController extends RefDropdownViewController {
  @override
  RefApi getApi() {
    return CityApi();
  }
}
