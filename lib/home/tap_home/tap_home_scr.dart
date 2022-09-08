import 'package:afariat/advert_details/advert_details_scr.dart';
import 'package:afariat/advert_details/advert_details_viewcontroller.dart';
import 'package:afariat/home/tap_profile/notification/notification_scr.dart';
import 'package:afariat/home/tap_profile/notification/notification_view_controller.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/bottom_sheet_filter.dart';
import 'package:afariat/home/tap_home/favorite/favorite_scr.dart';
import 'package:afariat/mywidget/myhomeitem.dart';
import 'package:afariat/mywidget/notification_menu.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:infinite_scroll_pagination/src/ui/default_indicators/first_page_error_indicator.dart';
import '../../config/Environment.dart';
import '../../config/app_config.dart';
import '../../mywidget/infinite_scroll/CustomFirstPageErrorIndicator.dart';
import 'favorite/parametres_scr.dart';
import 'tap_home_viewcontroller.dart';

class TapHomeScr extends GetWidget<TapHomeViewController> {
  // GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    var appConfig = AppConfig.of(context);
    Size _size = MediaQuery.of(context).size;
    Future.delayed(Duration(seconds: 1), () {
      controller.startIntro(context);
    });
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Container(
                height: 60,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        key: controller.intro.keys[0],
                        onTap: controller.openDrawer,
                        child: const Icon(
                          Icons.menu,
                          size: 40,
                          color: framColor,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35),
                                    bottomLeft: Radius.circular(35),
                                    bottomRight: Radius.circular(35)),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorGrey,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              child: GetBuilder<TapHomeViewController>(
                                  builder: (logic) {
                                return TextField(
                                  key: controller.intro.keys[1],
                                  controller: controller.searchWord,
                                  keyboardType: TextInputType.text,
                                  onChanged: controller.filterWord,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      suffixIcon: logic.searchWord.text
                                                  .toString()
                                                  .length >
                                              0
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.clear,
                                              ),
                                              onPressed: () {
                                                /* Clear the search field */
                                                controller.filterClearSearch();
                                              },
                                            )
                                          : null,
                                      hintText: 'Rechercher...',
                                      border: InputBorder.none),
                                );
                              }),
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                          key: controller.intro.keys[2],
                          // width: _size.width * .1,
                          child: InkWell(
                            onTap: () {
                              Get.find<TapPublishViewController>()
                                  .isButtonSheet = true;
                              Get.bottomSheet(
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0),
                                          )),
                                      child: BottomSheetFilter()),
                                  isDismissible: true,
                                  elevation: 10,
                                  enableDrag: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  )));
                              Get.find<TapPublishViewController>()
                                  .isButtonSheet = false;
                              Get.find<TapPublishViewController>()
                                  .clearAllData();
                              Filter.data.clear();
                            },
                            child: const Icon(
                              Icons.filter_alt_outlined,
                              size: 30,
                              color: colorGrey,
                            ),
                          )),
                      SizedBox(
                        key: controller.intro.keys[3],
                        child: Obx(() {
                          return NotificationMenu(
                            iconProfile: Icons.notifications_active,
                            hasNotification:
                                Get.find<NotificationViewController>()
                                    .hasNotification
                                    .value,
                            isNotification: true,
                            press: () {
                              if (Get.find<AccountInfoStorage>().isLoggedIn()) {
                                Get.find<NotificationViewController>()
                                    .hasNotification
                                    .value = false;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (
                                  context,
                                ) =>
                                        NotificationSrc()));
                              } else {
                                Get.snackbar("",
                                    " Veuillez vous connecter pour affiher vos notifications",
                                    colorText: Colors.white,
                                    backgroundColor: buttonColor);
                              }
                            },
                          );
                        }),
                      ),
                    ]),
              ))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
              children: [
                Get.find<NetWorkController>().connectionStatus.value == false
                    ? Container(
                        child: Center(child: CircularProgressIndicator()),
                        height: 50,
                        width: 50,
                      )
                    : SizedBox(),
                Get.find<NetWorkController>().connectionStatus.value
                    ? Expanded(
                        flex: 1,
                        child:
                            GetBuilder<TapHomeViewController>(builder: (logic) {
                          return logic.getDataFromWeb
                              ? Center(child: const CircularProgressIndicator())
                              : RefreshIndicator(
                                  onRefresh: () => Future.sync(
                                      () {} //  () => controller.pagingController.refresh(),
                                      ),
                                  child: PagedListView<int, dynamic>(
                                    scrollController:
                                        controller.scrollController,
                                    pagingController:
                                        controller.pagingController,
                                    builderDelegate:
                                        PagedChildBuilderDelegate<dynamic>(
                                      itemBuilder: (context, item, index) {
                                        if (item.description
                                                .toLowerCase()
                                                .contains(logic.searchWord.text
                                                    .toLowerCase()) ||
                                            item.title.toLowerCase().contains(
                                                logic.searchWord.text
                                                    .toLowerCase())) {
                                          return InkWell(
                                            onTap: () {
                                              Get.find<
                                                      AdvertDetailsViewController>()
                                                  .loading = true;
                                              Get.find<
                                                      AdvertDetailsViewController>()
                                                  .getAdvertDetails(item.id);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdvertDetailsScr()),
                                              );
                                            },
                                            child: MyHomeItem(
                                              size: _size,
                                              adverts: item,
                                            ),
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                      firstPageErrorIndicatorBuilder: (_) =>
                                          CustomFirstPageErrorIndicator(
                                        onTryAgain: () => controller
                                            .pagingController
                                            .refresh(),
                                      ),
                                    ),
                                  ),
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
                                  color: colorText),
                            ),
                          ],
                        )),
                      ))
              ],
            )),
      ),
      drawer: Container(
        width: _size.width * .6,
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/" +
                                appConfig.appName +
                                "/drawer.jpg",
                          ),
                          fit: BoxFit.fill)),
                  child: Container(
                    width: _size.width * .6,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, right: 8.0, left: 8),
                          child: GetBuilder<TapHomeViewController>(
                              builder: (logic) {
                            return Text(logic.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold));
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                //  Spacer(),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Get.find<AccountInfoStorage>().isLoggedIn()
                        ? Colors.red
                        : Colors.grey,
                  ),
                  title: const Text(
                    "Mes favoris",
                    style: TextStyle(
                        color: colorText, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    if (Get.find<AccountInfoStorage>().isLoggedIn()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FavoriteScr()),
                      );
                    } else {
                      Get.snackbar("Connexion requise",
                          "Veuillez vous connecter pour accéder à vos favoris",
                          colorText: Colors.white,
                          backgroundColor: buttonColor);
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Paramètres",
                    style: TextStyle(
                        color: colorText, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ParametreScr()),
                    );
                  },
                ),
                Divider(
                  thickness: 1,
                  color: colorText,
                ),
                ListTile(
                  leading: Icon(
                    Icons.help_center,
                    color: colorText,
                  ),
                  title: const Text(
                    "Centre d'aide",
                    style: TextStyle(
                        color: colorText, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    controller.launchURL(Environment.helpUrl);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.checklist,
                    color: colorText,
                  ),
                  title: const Text(
                    "Règlement",
                    style: TextStyle(
                        color: colorText, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    controller.launchURL(Environment.rulesUrl);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.https,
                    color: colorText,
                  ),
                  title: const Text(
                    "Confidentialité ",
                    style: TextStyle(
                        color: colorText, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    controller.launchURL(Environment.privacyUrl);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.gavel,
                    color: colorText,
                  ),
                  title: const Text(
                    "CGU ",
                    style: TextStyle(
                        color: colorText, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    controller.launchURL(Environment.cguUrl);
                  },
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
