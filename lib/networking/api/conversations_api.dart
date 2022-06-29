import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/resource_api.dart';
import 'package:afariat/networking/json/conversation_json.dart';

class ConversationsApi extends ResourceApi {
  int page;

  @override
  String apiUrl() {
    return SettingsApp.converstions + "?page=" + page.toString();
  }

  @override
  String apiDeleteUrl(String id) {
    return SettingsApp.converstions + "/" + id;
  }

  @override
  fromJson(data) {
    return ConversationJson.fromJson(data);
  }

  @override
  String apiPostUrl(dataToPost) {
    // TODO: implement apiPostUrl
    throw UnimplementedError();
  }

  @override
  String apiPutUrl({dataToPost}) {
    // TODO: implement apiPutUrl
    throw UnimplementedError();
  }
}
