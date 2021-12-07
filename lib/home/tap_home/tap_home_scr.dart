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
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Home",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                CustomTextFiled(
                    hintText: "rechercher",
                    width: _size.width * .55,
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
            ),
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
                            return MyHomeItem(
                              size: _size,
                              adverts: logic.adverts[pos],
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
