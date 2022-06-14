import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/conversation_json.dart';

class MessageApi extends ResourceApi {
  String id;
  int page;

  /// Function Get message from screen chat user
  @override
  String apiUrl() {
    return SettingsApp.getConversation + "/" + id + "?page=" + page.toString();
  }

  /// Function Post messageReply from screen chat user
  @override
  String apiPostUrl({dataToPost}) {
    return SettingsApp.Converstionreply + "/" + id;
  }

  @override
  String apiPutUrl({dataToPost}) {
    // TODO: implement apiPutUrl
    throw UnimplementedError();
  }

  @override
  String apiDeleteUrl(String id) {
    // TODO: implement apiDeleteUrl
    throw UnimplementedError();
  }

  @override
  fromJson(data) {
    return ConversationJson.fromJson(data);
  }
}
