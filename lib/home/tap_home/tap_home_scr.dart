import 'package:afariat/advert_details/advert_details_scr.dart';
import 'package:afariat/advert_details/advert_details_viewcontroller.dart';

import 'package:afariat/config/filter.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/bottom_sheet_filter.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/myhomeitem.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'tap_home_viewcontroller.dart';

class TapHomeScr extends GetWidget<TapHomeViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
              backgroundColor: Colors.white,
              title: Container(
                height: 60,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: _size.width * .12,
                        child: Image.asset(
                          "assets/images/Splash_1.png",
                          fit: BoxFit.fill,
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
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: controller.searchWord,
                                keyboardType: TextInputType.text,
                                onChanged: controller.filterword,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        /* Clear the search field */
                                        controller.filterclear();
                                      },
                                    ),
                                    hintText: 'Rechercher...',
                                    border: InputBorder.none),
                              ),
                            )),
                      ),
                      SizedBox(
                        width: _size.width * .1,
                        child: InkWell(
                          onTap: () {
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
                return logic.getdatafromweb
                    ? Center(child: const CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () => Future.sync(
                          () => controller.pagingController.refresh(),
                        ),
                        child: PagedListView<int, dynamic>(
                          pagingController: controller.pagingController,
                          //,scrollController: controller.scrollController,
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
                                    adverts: item, //logic.adverts[index],
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
    );
  }
}
