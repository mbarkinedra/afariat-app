import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/api/conversations_api.dart';
import 'package:afariat/networking/json/conversation_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TapChatViewController extends GetxController {
  bool getData = true;
  ConversationsApi _conversationApi = ConversationsApi();
  List<Conversation> conversations = [];
  RxBool hasConversaton = false.obs;

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
    _conversationApi.secureGet().then((value) {
      ConversationJson conversationJson = ConversationJson.fromJson(value.data);
      conversations = conversationJson.eEmbedded.conversation;

      getData = false;

      update();
    });
  }

  deleteConversation(int id, item) {
    _conversationApi.deleteResource(id.toString()).then((value) {
      conversations.remove(item);
      update();
    });

  }
}
