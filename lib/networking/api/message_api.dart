import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/conversation_json.dart';

abstract class MessageApi extends ApiManager {
  @override
  fromJson(data) {
    return ConversationJson.fromJson(data);
  }
}

class ConversationsReply extends MessageApi {
  String id;

  @override
  String apiUrl() {
    return SettingsApp.Converstionreply + "/" + id;
  }
}

class GetMessageApi extends MessageApi {
  String id;
  int page;

  @override
  String apiUrl() {
    return SettingsApp.getConverstion + "/" + id + "?page=" + page.toString();
  }
}
