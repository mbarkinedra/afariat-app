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
      appBar: AppBar(
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
                    // Text("Afariat",
                    //     style: TextStyle(
                    //         fontSize: 24,
                    //         fontWeight: FontWeight.w800,
                    //         color: Colors.deepOrange)),
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: GetBuilder<TapHomeViewController>(builder: (logic) {
                return logic.getdatafromweb
                    ? Center(child: const CircularProgressIndicator())
                    :
                    //                 :   PagedListView (
                    //             pagingController: logic.pagingController,
                    //             builderDelegate: PagedChildBuilderDelegate<AdvertJson>(
                    //             itemBuilder: (context, item, index) {
                    //
                    //
                    //               if (logic.adverts[index].description
                    //                   .toLowerCase()
                    //                   .contains(logic.searchWord.text.toLowerCase())||logic.adverts[index].title
                    //                   .toLowerCase()
                    //                   .contains(logic.searchWord.text.toLowerCase())) {
                    //                 return InkWell(onTap: (){
                    //                   print(logic.adverts[index].id);
                    //
                    //                   Get.find<AdvertDetailsViewcontroller>().loading=true;
                    //                   Get.find<AdvertDetailsViewcontroller>().getAdvertDetails(logic.adverts[index].id);
                    //                   Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(builder: (context) => AdvertDetatilsScr() ),
                    //                   );
                    //
                    //                 },
                    //                   child: MyHomeItem(
                    //                     size: _size,
                    //                     adverts: logic.adverts[index],
                    //                   ),
                    //                 );
                    //               } else {
                    //                 return const SizedBox();
                    //               }
                    // }
                    //
                    //             )

                    ListView.builder(
                        controller: logic.scrollController,
                        itemCount: logic.adverts.length,
                        itemBuilder: (context, pos) {
                          if (logic.adverts[pos].description
                                  .toLowerCase()
                                  .contains(
                                      logic.searchWord.text.toLowerCase()) ||
                              logic.adverts[pos].title.toLowerCase().contains(
                                  logic.searchWord.text.toLowerCase())) {
                            return InkWell(
                              onTap: () {
                                print(logic.adverts[pos].id);

                                Get.find<AdvertDetailsViewcontroller>()
                                    .loading = true;
                                Get.find<AdvertDetailsViewcontroller>()
                                    .getAdvertDetails(logic.adverts[pos].id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdvertDetatilsScr()),
                                );
                              },
                              child: MyHomeItem(
                                size: _size,
                                adverts: logic.adverts[pos],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        });
              }),
            )
          ],
        ),
      ),
    );
  }
}
