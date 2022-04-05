import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/api/conversations_api.dart';
import 'package:afariat/networking/api/delete_conversation_api.dart';
import 'package:afariat/networking/json/conversation_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:developer';

class TapChatViewController extends GetxController {
  bool getData = true;
  ConvertionsApi _getConvertionsApi = ConvertionsApi();
  List<Conversation> conversations = [];
  static const _pageSize = 20;
  RxBool hasConversaton = false.obs;
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);
  int page = 1;
  DeleteConversationApi _deleteConversationApi = DeleteConversationApi();
  ScrollController scrollController = ScrollController();
  Future<void> onRefreshAds() async {
    getAllConversations();
  }
  Future<void> _fetchPage(int pageKey) async {
    try {
      _getConvertionsApi.page = page;
      page++;

      final data = await _getConvertionsApi.secureGet();
      ConversationJson conversationJson = ConversationJson.fromJson(data.data);
      log(conversationJson.toJson().toString());
      final newItems = conversationJson.eEmbedded.conversation;
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(page);
    });
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
    pagingController.itemList.remove(item);
    conversations.remove(item);
    _deleteConversationApi.id = id.toString();
    _deleteConversationApi.deleteData().then((value) {
      update();
    });
    update();
  }
}
