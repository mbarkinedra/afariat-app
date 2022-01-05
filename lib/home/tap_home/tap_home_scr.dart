import 'dart:ui';

import 'package:afariat/advert_details/advert_details_scr.dart';
import 'package:afariat/advert_details/advert_details_viewcontroller.dart';
import 'package:afariat/assets/style.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/mywidget/bottom_sheet_filter.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/myhomeitem.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'tap_home_viewcontroller.dart';

class TapHomeScr extends GetWidget<TapHomeViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: Container(

            height: 40,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: _size.width * .2,
                    child: Text("Afariat",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.deepOrange)),
                  ),
                  SizedBox(
                    width: _size.width * .6,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  /* Clear the search field */
                                },
                              ),
                              hintText: 'Rechercher...',
                              border: InputBorder.none),
                        )),
                  ),
                  SizedBox(
                      width: _size.width * .1,
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.filter_alt_outlined,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ) ,
                  )
                ]),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
/*            const SizedBox(
              height: 30,
              child: Text(
                'Afariat',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Roboto",
                    color: Colors.deepOrange),
              ),
            ),
            Row(
              children: [
                // const Text(
                //   "Afariat",
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                CustomTextFiled(
                    hintText: "Rechercher",
                    width: _size.width * .70,
                    color: buttonColor,
                    keyboardType: TextInputType.text,
                    onchange: controller.filterword,
                    textEditingController: controller.searchWord),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
                InkWell(
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
                    Filter.m.clear();
                  },
                  child: const Icon(
                    Icons.filter_alt_outlined,
                    size: 30,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),*/
            Expanded(
              flex: 1,
              child: GetBuilder<TapHomeViewController>(builder: (logic) {
                return logic.getdatafromweb
                    ? Center(child: const CircularProgressIndicator())
                    : ListView.builder(
                    itemCount: logic.adverts.length,
                    itemBuilder: (context, pos) {
                      if (logic.adverts[pos].title
                          .toLowerCase()
                          .contains(logic.searchWord.text.toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            print(logic.adverts[pos].id);
                            Filter.Id = logic.adverts[pos].id.toString();
                            Get
                                .find<AdvertDetailsViewcontroller>()
                                .loading = true;
                            Get.find<AdvertDetailsViewcontroller>()
                                .getAdvertDetails();
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
