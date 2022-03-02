import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_publish/publish_views/apercu_publich.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/custom_button2.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PublishImageScr extends GetView<TapPublishViewController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.deepOrange,
          title: Text(
            "Deposer annonces",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            GetBuilder<TapPublishViewController>(builder: (logic) {
              return IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  color:
                      logic.images.length < 6 ? Colors.white : Colors.black45,
                ),
                iconSize: 40,
                onPressed: () {
                  if (controller.images.length < 6) {
                    showOptionsDialog(context);
                  } else {
                    Get.snackbar("Erreur",
                        "Vous ne pouvez ajouter que **6** photos par annonce");
                  }
                },
              );
            })
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
                  child: Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Rajouter des photos :",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Une annonce avec des images attire beaucoup l'attention des internautes.Utilisez une image réelle de votre objet, et non de catalogues",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GetBuilder<TapPublishViewController>(builder: (logic) {
                  return logic.dataAdverts
                      ? logic.editAdsImages.length > 0
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              children: logic.editAdsImages
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
                                                    color: Colors.deepOrange,
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
                              height: size.height * .5,
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
                                                    logic.deleteImage(e);
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 30,
                                                    color: Colors.deepOrange,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (controller.images.length < 6) {
                                  showOptionsDialog(context);
                                } else {
                                  Get.snackbar("Erreur",
                                      "Vous ne pouvez ajouter que **6** photos par annonce");
                                }
                              },
                              child: Image.asset(
                                "assets/images/placeholder.png",
                                width: size.width,
                                height: size.height * .5,
                              ),
                            );
                }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 40, right: 8, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton1(
                          width: MediaQuery.of(context).size.width * .35,
                          height: 45,
                          label: "Précédent",
                          labcolor: Colors.white,
                          icon: Icons.arrow_back_rounded,
                          iconcolor: Colors.white,
                          btcolor: buttonColor,
                          function: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CustomButton2(
                            width: MediaQuery.of(context).size.width * .35,
                            height: 45,
                            label: "Suivant",
                            icon: Icons.arrow_forward_rounded,
                            iconcolor: Colors.white,
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
            title: Text(
              "Selectionner votre options :",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Prendre une photo"),
                    onTap: () async {
                      controller.openCamera();
                      Navigator.pop(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Choisir une image"),
                    onTap: () async {
                      controller.openGallery();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
