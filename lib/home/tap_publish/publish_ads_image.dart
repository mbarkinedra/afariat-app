import 'dart:io';

import 'package:afariat/config/utilitie.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'publishadsImage_viewcontroller.dart';

class PublishAdsImage extends GetView<PublishadsImageViewController> {
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      showOptionsDialog(context, 1);
                    },
                    child: Container(
                      width: size.width * .8,
                      height: size.height * .3,
                      child: controller.image == null
                          ? Image.asset("assets/images/img_placeholder.jpg")
                          : Image.file(
                              controller.image,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      showOptionsDialog(context, 2);
                    },
                    child: Container(
                      width: size.width * .8,
                      height: size.height * .3,
                      child: controller.image2 == null
                          ? Text("pppppppppp")//Image.asset("assets/images/img_placeholder.jpg")
                          : Image.file(controller.image2),
                    ),
                  ),
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
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (
                        //   context,
                        // ) =>
                        //         PublishSucces()));
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
                    onTap: () {
                   //   controller.openCamera(image);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () async {
                     // controller.openGallery(image);
                    // var imgCamera = await  ImagePicker.pickImage(source: ImageSource.gallery);

    var imgGallery = await  ImagePicker.pickImage(source: ImageSource.gallery);

     // image = File(imgGallery.path);
 // controller.  updateImage (controller.image ,imgGallery);
  },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
