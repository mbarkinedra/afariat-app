import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/conversation_json.dart';

class GetMessageApi extends ApiManager {
  String id;
  int page;

  @override
  String apiUrl() {
    return SettingsApp.getConverstion + "/" + id + "?page=" + page.toString();
  }

  @override
  fromJson(data) {
    return ConversationJson.fromJson(data);
  }
}
