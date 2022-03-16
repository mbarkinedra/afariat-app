import 'package:afariat/advert_details/advert_details_scr.dart';
import 'package:afariat/advert_details/advert_details_viewcontroller.dart';

import 'package:afariat/config/filter.dart';
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
                        width: _size.width * .13,
                        child: InkWell(
                          onTap: controller.openDrawer,
                          child: Image.asset(
                            "assets/images/Splash_2.png",
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
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    // changes position of shadow
                                  ),
                                ],
                              ),
                              child: GetBuilder<TapHomeViewController>(
                                  builder: (logic) {
                                return TextField(
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
                                                controller.filterClear();
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
                        width: _size.width * .1,
                        child: InkWell(
                          onTap: () {
                           Get.find<TapPublishViewController>().isButtonSheet=true;
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
                           Get.find<TapPublishViewController>().isButtonSheet=false;
                           Get.find<TapPublishViewController>().   clearAllData();
                            Filter.data.clear();
                          },
                          child: const Icon(
                            Icons.filter_alt_outlined,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ]),
              ))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: GetBuilder<TapHomeViewController>(builder: (logic) {
                return logic.getDataFromWeb
                    ? Center(child: const CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () => Future.sync(
                          () => controller.pagingController.refresh(),
                        ),
                        child: PagedListView<int, dynamic>(
                          pagingController: controller.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<dynamic>(
                            itemBuilder: (context, item, index) {
                              if (item.description.toLowerCase().contains(
                                      logic.searchWord.text.toLowerCase()) ||
                                  item.title.toLowerCase().contains(
                                      logic.searchWord.text.toLowerCase())) {
                                return InkWell(
                                  onTap: () {
                                    Get.find<AdvertDetailsViewcontroller>()
                                        .loading = true;
                                    Get.find<AdvertDetailsViewcontroller>()
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
          ],
        ),
      ),
      drawer: Container(
        width: _size.width * .6,
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/Splash_6.png",height: _size.height*.1,width: _size.width*.3,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  GetBuilder<TapHomeViewController>(builder: (logic) {
                          return Text(
                            logic.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold));
                        }
                      ),
                    ),
                  ],
                ),
              ),
         // SizedBox(height: 35,),
              ListTile(
                leading: Icon(Icons.help_center),
                title: const Text(
                  "Centre d'aide",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  controller.launchURL("https://afariat.com/aide.html");
                  // Navigator.pop(context);
                },
              ),
      /*        ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
