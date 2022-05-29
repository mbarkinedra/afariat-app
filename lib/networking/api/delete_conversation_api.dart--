import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/conversation_json.dart';

class DeleteConversationApi extends ApiManager {
  String id;

  @override
  String apiUrl() {
    return SettingsApp.converstions + "/" + id;
  }

  @override
  fromJson(data) {
    return ConversationJson.fromJson(data);
  }
}
