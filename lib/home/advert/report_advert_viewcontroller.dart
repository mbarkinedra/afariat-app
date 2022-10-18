import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../config/app_routing.dart';
import '../../networking/api/abuse_api.dart';
import '../../networking/api/ref_api.dart';
import '../../networking/json/advert_details_json.dart';
import '../../networking/json/get_json_response.dart';
import '../../networking/json/post_json_response.dart';
import '../../networking/json/ref_json.dart';
import '../../validator/validator_abuse.dart';

class ReportAdvertViewController extends GetxController {
  AdvertDetailsJson advert;
  final CategoryAbuseApi _categoryAbuseApi = CategoryAbuseApi();
  final AbuseApi _api = AbuseApi();
  RefListJson abuseCategories;
  RxBool isLoadingCategories = false.obs;
  RxBool isSending = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();
  RefJson _selectedCategory;
  ValidatorAbuse validator = ValidatorAbuse();
  final reportAbuseFormKey = GlobalKey<FormState>();
  RxString error = ''.obs;

  @override
  Future<void> onInit() async {
    await fetchCategories();
    super.onInit();
  }

  fetchCategories() async {
    error.value = '';
    isLoadingCategories.value = true;
    try {
      GetJsonResponse _jsonResponse = await _categoryAbuseApi.getJsonResponse();

      if (_jsonResponse == null) {
        error.value =
            'Un problème est survenu. Veuillez réessayer un peu plus tard.';
        return;
      }
      if (_jsonResponse.hasErrors()) {
        error.value = _jsonResponse.message;
        return;
      }
      abuseCategories = _jsonResponse.data;
    } catch (e) {
      error.value =
          'Un problème est survenu. Veuillez réessayer un peu plus tard.';
      if (kDebugMode) {
        print(e);
        throw e;
      }
    }
    isLoadingCategories.value = false;
  }

  updateSelectedCategory(RefJson refJson) {
    _selectedCategory = refJson;
  }

  sendReport() async {
    error.value = '';
    isSending.value = true;
    try {
      PostJsonResponse jsonResponse = await _api.sendReport(
        advertId: advert.id,
        message: message.text,
        categoryId: _selectedCategory.id,
        email: email.text,
      );
      if (jsonResponse == null) {
        //probably it's a 500 error. TODO: FIX this in api_manager
        error.value = 'Un problème est survenu.' +
            ' Veuillez réessayer un peu plus tard.';
        return;
      }

      if (jsonResponse.hasErrors() &&
          jsonResponse.errors.globalErrors.isNotEmpty) {
        error.value = jsonResponse.message;
      }

      validator.formValidator.validateServer(
          postJsonResponse: jsonResponse,
          success: () {
            //Go to success page
            Get.toNamed(
              AppRouting.adReportSuccess,
              parameters: {'message': jsonResponse.message},
            );
          },
          failure: () {
            //validate server errors and show them in the form
            reportAbuseFormKey.currentState.validate();
          });
    } catch (e) {
      if (kDebugMode) {
        print(e);
        throw e;
      }
    }
    isSending.value = false;
  }
}
