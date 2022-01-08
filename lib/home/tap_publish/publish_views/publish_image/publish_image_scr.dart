import 'dart:io';

import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_publish/publish_views/apercu_publich.dart';
import 'package:afariat/home/tap_publish/publish_views/publish_succes.dart';
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
        appBar: AppBar(title: Text("Publish Ads")),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GetBuilder<TapPublishViewController>(builder: (logic) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          showOptionsDialog(context, 1);
                        },
                        child:
                           Container(decoration: BoxDecoration(border: Border.all(color: framColor),borderRadius: BorderRadius.circular(10)),
                            width: size.width * .8,
                            height: size.height * .3,
                            child: controller.image == null
                                ?  Image.asset(
                              'assets/images/placeholder.png',
                              width: size.width,
                              fit: BoxFit.fill,
                            )
                                :

                                   Image.file(
                              controller.image,
                              fit: BoxFit.fill,
                            ),
                            ),


                       ),
                      );
                  }
                ),

                GetBuilder<TapPublishViewController>(builder: (logic) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showOptionsDialog(context, 2);
                        },
                        child: Container( decoration: BoxDecoration(border: Border.all(color: framColor),borderRadius: BorderRadius.circular(10)),
                              width: size.width * .8,
                              height: size.height * .3,
                              child: controller.image2 == null
                                  ? Image.asset(
                                'assets/images/placeholder.png',
                                width: size.width,
                                fit: BoxFit.fill,
                              )
                                  : Image.file(controller.image2 , fit: BoxFit.fill, ),
                            )

                        ),
                      );
                  }
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      width: MediaQuery.of(context).size.width * .4,
                      height: 50,
                      label: "Previous",
                      btcolor: buttonColor,
                      function: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CustomButton(
                      width: MediaQuery.of(context).size.width * .4,
                      height: 50,
                      label: "Next",
                      btcolor: buttonColor,
                      function: () {
                        if(controller.image!=null||controller.image2!=null){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (
                                  context,
                                  ) =>
                                  ApercuPublich()));
                        }else{
                          Get.snackbar("حطاء", "يجب ادخال صوره علي الاقل");
                        }

                      },
                    ),

                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> showOptionsDialog(BuildContext context, image) {
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
                    onTap: () async{

                      // var imgGallery = await  ImagePicker.pickImage(source: ImageSource.camera);
                      //
                      // // image = File(imgGallery.path);
                      // Get.find<PublishadsImageViewController>().  updateImage ( Get.find<PublishadsImageViewController>().image ,imgGallery);
                      controller.openCamera(image);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () async {
                    controller.openGallery( image);
              //Get.find<PublishadsImageViewController>().  updateImage ( Get.find<PublishadsImageViewController>().image ,imgGallery);
  },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
