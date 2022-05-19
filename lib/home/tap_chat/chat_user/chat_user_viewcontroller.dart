import 'dart:convert';
import 'dart:math';

import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/networking/api/conversations_api.dart';
import 'package:afariat/networking/api/conversationsreply.dart';
import 'package:afariat/networking/api/get_message_api.dart';
import 'package:afariat/networking/json/conversation_json.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatUserViewController extends GetxController {
  TextEditingController controller = TextEditingController();
  ConversationsReply _conversationsReply = ConversationsReply();
  GetMessageApi _getMessageApi = GetMessageApi();
  ConversationsApi _convertionsApi = ConversationsApi();
  List<Conversation> conversations = [];
  AccountInfoStorage _accountInfoStorage = AccountInfoStorage();
  ScrollController scrollController = ScrollController();
  List<types.Message> messages = [];
  String name = "";
  String userID;
  String userName = "";
  RxBool send = false.obs;
  String imagelink;
  String id;
  String message = "";
  int page = 1;
  static const _pageSize = 20;
  var user;
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    super.onInit();
    user = types.User(id: _accountInfoStorage.readUserId());
    messages.clear();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      _getMessageApi.page = page;
      page++;
      final data = await _getMessageApi.secureGet();
      ConversationJson conversationJson = ConversationJson.fromJson(data.data);
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

  Future getMessage() async {

    _getMessageApi.id = id;
    await _getMessageApi.secureGet().then((value) {
      ConversationJson conversationJson = ConversationJson.fromJson(value.data);
      conversations = conversationJson.eEmbedded.conversation;
      messages.clear();
      conversations.forEach((element) {

        final textMessage = types.TextMessage(
            author: types.User(
              id: _accountInfoStorage.readUserId(),
              firstName:element.from.name,
            ),
            id: element.from.id.toString(),
            text: element.message,
            type: types.MessageType.text);

        messages.add(textMessage);
      });
      update();
      page++;
    });
  }

  sendChat() {
    _conversationsReply.id = id;
    _conversationsReply
        .securePost(dataToPost: {"message": message}).then((value) async {
      await getMessage();
      update();

    });
  }

  sendIdAndImage() async {
    Filter.data["message"] = imagelink;
    Filter.data["advert"] = id;
    await _convertionsApi.securePost(dataToPost: Filter.data);
    getMessage();
    update();
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void addMessage(types.Message message) {
    messages.insert(0, message);
    update();
  }

  void handleSendPressed(types.PartialText message) {
    sendChat();
  }

  setUserName({String username}) {
    userName = username;
  }

  onChanged(String v) {
    if (v.trim().isNotEmpty) {
      send.value = true;
    } else {
      send.value = false;
    }
  }

  Widget bubbleBuilder(
    Widget child, {
    message,
    nextMessageInGroup,
  }) {
    return Bubble(
      alignment: _accountInfoStorage.readUserId() != message.id
          ? Alignment.bottomLeft
          : Alignment.bottomRight,
      child: child,
      color: _accountInfoStorage.readUserId() != message.id
          ? const Color(0xffc2c2c2)
          : const Color(0xFFF55702),
      style: BubbleStyle(
          alignment: _accountInfoStorage.readUserId() != message.id
              ? Alignment.topLeft
              : Alignment.topRight),
      margin: nextMessageInGroup
          ? const BubbleEdges.symmetric(
              horizontal: 0,
            )
          : null,
      nip: _accountInfoStorage.readUserId() != message.id
          ? BubbleNip.leftBottom
          : BubbleNip.rightBottom,
    );
  }
}
