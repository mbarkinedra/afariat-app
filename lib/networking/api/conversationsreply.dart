import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/api/api_manager.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

class ConversationsReply extends ApiManager {
  String id;

  @override
  String apiUrl() {
    return SettingsApp.Converstionreply +"/"+ id;
  }

  @override
  AbstractJsonResource fromJson(data) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
