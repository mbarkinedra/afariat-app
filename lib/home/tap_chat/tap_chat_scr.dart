import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/mywidget/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../persistent_tab_manager.dart';
import 'chat_user/chat_user_scr.dart';
import 'chat_user/chat_user_viewcontroller.dart';
import 'tap_chat_viewcontroller.dart';

class TapChatScr extends GetWidget<TapChatViewController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text(
            "Messagerie",
            style: TextStyle(
                color: colorGrey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(
                //
                Icons.arrow_back_ios,
                color: framColor,
              ),
              onPressed: () {
                PersistentTabManager.changePage(0);
              }),
        ),
        body: Obx(
          () => Column(
            children: [
              Get.find<NetWorkController>().connectionStatus.value == false
                  ? Container(
                      child: const Center(child: CircularProgressIndicator()),
                      height: 50,
                      width: 50,
                    )
                  : const SizedBox(),
              Get.find<NetWorkController>().connectionStatus.value
                  ? Expanded(
                      child:
                          GetBuilder<TapChatViewController>(builder: (logic) {
                        return logic.getData
                            ? const Center(child: CircularProgressIndicator())
                            : RefreshIndicator(
                                onRefresh: controller.onRefreshAds,
                                child: logic.conversations.isEmpty
                                    ? const Center(
                                        child: Text(
                                          "Aucun message",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black38,
                                              fontSize: 22),
                                        ),
                                      )
                                    : ListView.builder(
                                        controller: controller.scrollController,
                                        itemCount: logic.conversations.length,
                                        itemBuilder: (context, position) {
                                          logic.conversations
                                              .forEach((element) {});
                                          return Dismissible(
                                            background: Container(
                                              color: Colors.red,
                                              child: const Icon(
                                                Icons.delete,
                                                size: 35,
                                                color: Colors.white,
                                              ),
                                            ),
                                            key: UniqueKey(),
                                            onDismissed: (direction) {
                                              controller.deleteConversation(
                                                  logic.conversations[position]
                                                      .id,
                                                  logic
                                                      .conversations[position]);
                                            },
                                            child: GestureDetector(
                                                onTap: () {
                                                  Get.find<
                                                          ChatUserViewController>()
                                                      .name = logic
                                                              .conversations[
                                                                  position]
                                                              .to
                                                              .username ==
                                                          Get.find<
                                                                  AccountInfoStorage>()
                                                              .readEmail()
                                                      ? logic
                                                          .conversations[
                                                              position]
                                                          .from
                                                          .username
                                                      : logic
                                                          .conversations[
                                                              position]
                                                          .to
                                                          .username;
                                                  Get.find<ChatUserViewController>()
                                                          .id =
                                                      logic
                                                          .conversations[
                                                              position]
                                                          .id
                                                          .toString();
                                                  Get.find<
                                                          ChatUserViewController>()
                                                      .messages
                                                      .clear();
                                                  Get.find<
                                                          ChatUserViewController>()
                                                      .getMessage();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatUserScr()));
                                                },
                                                child: ChatUser(
                                                  conversation: logic
                                                      .conversations[position],
                                                  email: Get.find<
                                                          AccountInfoStorage>()
                                                      .readEmail(),
                                                  hasConversaton: logic
                                                          .conversations[
                                                              position]
                                                          .totalUnreadMessagesCount >
                                                      0,
                                                )),
                                          );
                                        }),
                              );
                      }),
                    )
                  : Expanded(
                      child: Container(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off_rounded,
                            size: 80,
                            color: framColor,
                          ),
                          Text(
                            "Pas de connexion internet",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      )),
                    )),
            ],
          ),
        ));
  }
}
