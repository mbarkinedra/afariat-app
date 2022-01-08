import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/ads_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tap_myads_viewcontroller.dart';

class TapMyadsScr extends GetWidget<TapMyadsViewController>{

  @override
  Widget build(BuildContext context) {
    Size _size=MediaQuery.of(context).size;
    controller.ads();
    return SafeArea(
      child: Scaffold(appBar: AppBar(title:  Text(
        "Mes annonces",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      ),backgroundColor: Colors.deepOrangeAccent,),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //      ,
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(50.0),
            //         child: Container(
            //           color: framColor,
            //           height: 50,
            //           width: 50,
            //           child: Center(
            //               child: Icon(
            //                 Icons.add,
            //                 color: Colors.white,
            //               )),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            Expanded(
              child: GetBuilder<TapMyadsViewController>(builder: (logic) {
                  return ListView.builder(
                      itemCount: logic.adverts.length,
                      itemBuilder: (context, pos) {
                        return AdsItem(
                         size: _size,adverts: logic.adverts[pos],fun: (){
                           print(logic.adverts[pos].id);
                           controller.delads(logic.adverts[pos].id);
                        },
                        );
                      });
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

}