import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/conversation_json.dart';

class ConversationsApi extends ResourceApi {
  int page;

  /// Function Get List all conversation in screen chat
  @override
  String apiUrl() {
    return SettingsApp.conversations + "?page=" + page.toString();
  }

  /// Function delete from List  conversation in screen chat
  @override
  String apiDeleteUrl(String id) {
    return SettingsApp.conversations + "/" + id;
  }

  /// Function Post message From screen advertDetails
  @override
  String apiPostUrl({dataToPost}) {
    return SettingsApp.conversations;
  }

  @override
  String apiPutUrl({dataToPost}) {
    // TODO: implement apiPutUrl
    throw UnimplementedError();
  }

  @override
  fromJson(data) {
    return ConversationJson.fromJson(data);
  }
}
