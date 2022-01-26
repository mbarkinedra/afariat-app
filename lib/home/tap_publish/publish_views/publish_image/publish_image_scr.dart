import 'dart:io';

import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_publish/publish_views/apercu_publich.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'publish_image_viewcontroller.dart';

class PublishImageScr extends GetView<TapPublishViewController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Deposer une annonce "),
          actions: [
            IconButton(
              icon: Icon(Icons.add_a_photo),
              iconSize: 40,
              onPressed: () {
                showOptionsDialog(context);
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Selectionner des images : ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                GetBuilder<TapPublishViewController>(builder: (logic) {
                  return logic.dataAdverts
                      ? logic.editadsimages.length > 0
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              children: logic.editadsimages
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: framColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              width: size.width * .8,
                                              height: size.height * .3,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  e,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: InkWell(
                                                  onTap: () {
                                                    logic.deleditImage(e);
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 30,
                                                    color:
                                                        Colors.deepOrange,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            )
                          : Image.asset(
                              "assets/images/placeholder.png",
                              width: size.width,
                              height: size.height * .8,
                            )
                      : logic.images.length > 0
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              children: logic.images
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: framColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              width: size.width * .8,
                                              height: size.height * .3,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  e,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: InkWell(
                                                  onTap: () {
                                                    logic.delImage(e);
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 30,
                                                    color:
                                                        Colors.deepOrange,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            )
                          : Image.asset(
                              "assets/images/placeholder.png",
                              width: size.width,
                              height: size.height * .8,
                            );
                }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        width: MediaQuery.of(context).size.width * .35,
                        height: 45,
                        label: "Précédent",
                        labcolor: Colors.white,
                        btcolor: buttonColor,
                        function: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CustomButton(
                          width: MediaQuery.of(context).size.width * .35,
                          height: 45,
                          label: "Suivant",
                          labcolor: Colors.white,
                          btcolor: buttonColor,
                          function: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (
                              context,
                            ) =>
                                    ApercuPublich()));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Capture Image From Camera"),
                    onTap: () async {
                      controller.openCamera();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () async {
                      controller.openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
