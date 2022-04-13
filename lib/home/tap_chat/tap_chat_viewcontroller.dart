import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/api/conversations_api.dart';
import 'package:afariat/networking/api/delete_conversation_api.dart';
import 'package:afariat/networking/json/conversation_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TapChatViewController extends GetxController {
  bool getData = true;
  ConversationsApi _getConvertionsApi = ConversationsApi();
  List<Conversation> conversations = [];
  RxBool hasConversaton = false.obs;

  DeleteConversationApi _deleteConversationApi = DeleteConversationApi();
  ScrollController scrollController = ScrollController();

  Future<void> onRefreshAds() async {
    getAllConversations();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (Get.find<NetWorkController>().connectionStatus.value) {
      getAllConversations();
    }
  }

  getAllConversations() {
    _getConvertionsApi.secureGet().then((value) {
      ConversationJson conversationJson = ConversationJson.fromJson(value.data);
      conversations = conversationJson.eEmbedded.conversation;

      getData = false;

      update();
    });
  }

  deleteConversation(int id, item) {
    conversations.remove(item);
    _deleteConversationApi.id = id.toString();
    _deleteConversationApi.deleteData().then((value) {
      update();
    });
    update();
  }
}
