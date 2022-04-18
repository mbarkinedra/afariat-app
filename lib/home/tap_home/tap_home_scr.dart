import 'package:afariat/advert_details/advert_details_scr.dart';
import 'package:afariat/advert_details/advert_details_viewcontroller.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/bottom_sheet_filter.dart';
import 'package:afariat/mywidget/myhomeitem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'tap_home_viewcontroller.dart';

class TapHomeScr extends GetWidget<TapHomeViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    Future.delayed(Duration(seconds: 1), () {

     // controller.intro.start(context);
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        key: controller.intro.keys[0],
                        width: _size.width * .13,
                        child: InkWell(
                          onTap: controller.openDrawer,
                          child: Image.asset(
                            "assets/images/Splash_10.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: _size.width * .6,
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
                                    color: ColorGrey,
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
                        key: controller.intro.keys[2],
                        width: _size.width * .1,
                        child: InkWell(
                          onTap: () {
                            Get.find<TapPublishViewController>().isButtonSheet =
                                true;
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
                            Get.find<TapPublishViewController>().isButtonSheet =
                                false;
                            Get.find<TapPublishViewController>().clearAllData();
                            Filter.data.clear();
                          },
                          child: const Icon(
                            Icons.filter_alt_outlined,
                            size: 30,
                            color: ColorGrey,
                          ),
                        ),
                      )
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
                                    () => controller.pagingController.refresh(),
                                  ),
                                  child: PagedListView<int, dynamic>(
                                    scrollController:
                                        controller.scrollController,
                                    pagingController:
                                        controller.pagingController,
                                    addAutomaticKeepAlives: true,
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
                                                      AdvertDetailsViewcontroller>()
                                                  .loading = true;
                                              Get.find<
                                                      AdvertDetailsViewcontroller>()
                                                  .getAdvertDetails(item.id);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdvertDetatilsScr()),
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
                                  color: ColorText),
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
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/drawer.png",
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
                        padding:
                            const EdgeInsets.only(top: 30, right: 8.0, left: 8),
                        child:
                            GetBuilder<TapHomeViewController>(builder: (logic) {
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
              Spacer(),
              Divider(
                thickness: 1,
                color: ColorText,
              ),
              ListTile(
                leading: Icon(
                  Icons.help_center,
                  color: ColorText,
                ),
                title: const Text(
                  "Centre d'aide",
                  style:
                      TextStyle(color: ColorText, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  controller.launchURL("https://afariat.com/aide.html");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.checklist,
                  color: ColorText,
                ),
                title: const Text(
                  "Règlement",
                  style:
                      TextStyle(color: ColorText, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  controller.launchURL("https://afariat.com/règlement.html");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.https,
                  color: ColorText,
                ),
                title: const Text(
                  "Confidentialité ",
                  style:
                      TextStyle(color: ColorText, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  controller
                      .launchURL("https://afariat.com/confidentialite.html");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.gavel,
                  color: ColorText,
                ),
                title: const Text(
                  "CGU ",
                  style:
                      TextStyle(color: ColorText, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  controller.launchURL(
                      "https://afariat.com/conditions-générales-d-utilisation.html");
                },
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
