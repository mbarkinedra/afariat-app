import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/networking/json/conversation_json.dart';
import 'package:afariat/networking/json/notification_json.dart';

class ConvertionsApi extends ApiManager {
  @override
  int page;

  String apiUrl() {
    return SettingsApp.converstions+"?page="+page.toString();;
  }

  @override
  fromJson(data) {
    return ConversationJson.fromJson(data);
  }
}
