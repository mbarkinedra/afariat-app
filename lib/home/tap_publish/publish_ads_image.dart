/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      child: _image == null
                          ? Image.asset("assets/images/img_placeholder.jpg")
                          : Image.file(
                              _image,
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
                      child: _image2 == null
                          ? Image.asset("assets/images/img_placeholder.jpg")
                          : Image.file(_image2),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DesignForm(
                      width: MediaQuery.of(context).size.width * .4,
                      hight: 50,
                      label: "Next",
                      backcolor: OrColor,
                      onpress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (
                          context,
                        ) =>
                                PublishSucces()));
                      },
                    ),
                    DesignForm(
                      width: MediaQuery.of(context).size.width * .4,
                      hight: 50,
                      label: "Previous",
                      backcolor: OrColor,
                      onpress: () {
                        Navigator.of(context).pop();
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
                      openCamera(image);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () {
                      openGallery(image);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera(int image) async {
    var imgCamera = await picker.getImage(source: ImageSource.camera);
    if (image == 1) {
      setState(() {
        _image = File(imgCamera.path);
      });
    } else {
      setState(() {
        _image = File(imgCamera.path);
      });
    }
  }

  void openGallery(int image) async {
    var imgGallery = await picker.getImage(source: ImageSource.gallery);
    if (image == 1) {
      setState(() {
        _image = File(imgGallery.path);
      });
    } else {
      setState(() {
        _image2 = File(imgGallery.path);
      });
    }

    // Navigator.of(context).pop();
  }
}
*/
