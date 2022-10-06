import 'package:afariat/networking/json/abstract_json_resource.dart';
import '../../config/settings_app.dart';
import '../json/localization_json.dart';
import '../json/serach_suggestion.dart';
import 'api_manager.dart';

class AutocompleteLocalizationApi extends ApiManager {
  @deprecated
  String search;

  @override
  @deprecated
  String apiUrl() => SettingsApp.autocompleteLocalization + "?search=" + search;

  @override
  AbstractJsonResource fromJson(data) {
    return LocalizationListJson.fromJson(data);
  }

  @override
  String baseApiUrl() {
    return SettingsApp.autocompleteLocalization;
  }
}

class AutocompleteSearchSuggestionApi extends ApiManager {
  Future<SearchSuggestionListJson> getSuggestions(String term) async {
    String _url = baseApiUrl() + "?search=" + term;
    return await getCollection(_url);
  }

  @override
  AbstractJsonResource fromJson(data) {
    return SearchSuggestionListJson.fromJson(data);
  }

  @override
  String baseApiUrl() {
    return SettingsApp.autocompleteSearchSuggestion;
  }

  @override
  String apiUrl() {
    // TODO: implement apiUrl. Should be removed when removing apiUrl from parent
    throw UnimplementedError();
  }
}
