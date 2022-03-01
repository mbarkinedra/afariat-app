import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/conversation_json.dart';

class ConvertionsApi extends ApiManager {
  int page;

  @override
  String apiUrl() {
    return SettingsApp.converstions + "?page=" + page.toString();
  }

  @override
  fromJson(data) {
    return ConversationJson.fromJson(data);
  }
}
