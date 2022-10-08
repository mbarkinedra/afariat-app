import 'package:afariat/config/app_routing.dart';
import 'package:afariat/networking/json/advert_details_json.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../config/Environment.dart';
import '../../config/utility.dart';
import '../../model/advert_option_labels.dart';
import '../../mywidget/advert_card_grid.dart';
import '../../mywidget/advert_card_list.dart';
import '../search/similar_adverts_viewcontroller.dart';
import 'advert_details_viewcontroller.dart';

class AdvertDetailsView extends GetWidget<AdvertDetailsViewController> {
  AdvertDetailsView({Key key}) : super(key: key);
  final numberFormat = NumberFormat("###,##0", Environment.locale);
  final _sendMsgFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    controller.advertId = Get.parameters['id'];
    return Scaffold(
      // key: controller.key,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: framColor,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Annonce détaillée",
          style: TextStyle(color: colorText, fontSize: 20),
        ),
        leading: IconButton(
            icon: const Icon(
              //
              Icons.arrow_back_ios,
              color: framColor,
            ),
            onPressed: () {
              Get.back();
            }),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<AdvertDetailsJson>(
            future: controller.fetchAdvert(),
            builder: (context, AsyncSnapshot<AdvertDetailsJson> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      _buildCarousel(context),
                      _buildAdvert(),
                      _buildRelatedAds(context),
                    ],
                  ),
                );
              } else {
                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Obx(() => controller.loading.isTrue
              ? const Center(child: CircularProgressIndicator())
              : controller.advert.showPhoneNumber
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              child: const Padding(
                                child: Icon(Icons.call),
                                padding: EdgeInsets.all(12),
                              ),
                              onPressed: () {
                                controller.makeCallOrSms(
                                    controller.advert.mobilePhoneNumber, 'tel');
                              },
                              style: OutlinedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  side: const BorderSide(
                                      width: 1, color: Colors.grey)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: FloatingActionButton(
                              child: const Icon(Icons.chat),
                              tooltip: 'Envoyer un message',
                              onPressed: () =>
                                  _showSendMessageDialogContent(context),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              child: const Padding(
                                child: Text(
                                  'SMS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                padding: EdgeInsets.all(16),
                              ),
                              onPressed: () {
                                controller.makeCallOrSms(
                                    controller.advert.mobilePhoneNumber, 'sms');
                              },
                              style: OutlinedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  side: const BorderSide(
                                      width: 1, color: Colors.grey)),
                            ),
                          ),
                        ])
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () =>
                              _showSendMessageDialogContent(context),
                          label: const Text('Message'),
                          icon: const Icon(Icons.chat),
                        )
                      ],
                    ))),
    );
  }

  _buildCarousel(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    if (controller.advert.photos == null) {
      return const SizedBox();
    }

    return controller.advert.photos.length > 1
        ? CarouselSlider(
            options: CarouselOptions(
              height: _size.height * .3,
              viewportFraction: .7,
              aspectRatio: 9 / 12,
              enlargeCenterPage: true,
              autoPlay: true,
            ),
            items: controller.advert.photos
                .map((item) => InkWell(
                    onTap: () {
                      _showGallery(context);
                    },
                    child: CachedNetworkImage(
                      imageUrl: item.path,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => const Align(
                              alignment: Alignment.center,
                              child: CupertinoActivityIndicator()),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/common/no-image.jpg",
                        fit: BoxFit.fill,
                      ),
                    )))
                .toList(),
          )
        : controller.advert.photos.isNotEmpty
            ? InkWell(
                onTap: () {
                  _showGallery(context);
                },
                child: Container(
                    height: _size.height * .3,
                    child: CachedNetworkImage(
                      imageUrl: controller.advert.photos[0].path,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => const Align(
                              alignment: Alignment.center,
                              child: CupertinoActivityIndicator()),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/common/no-image.jpg",
                        fit: BoxFit.fill,
                      ),
                    )),
              )
            : const SizedBox();
  }

  _buildAdvert() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            controller.advert.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.grey,
              size: 14,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  controller.advert.town.name +
                      (controller.advert.town.zipCode != null
                          ? '(' + controller.advert.town.zipCode + ')'
                          : '') +
                      ', ' +
                      controller.advert.city.name +
                      (controller.advert.city.codeInsee != null
                          ? ' - ' + controller.advert.city.codeInsee
                          : ''),
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6), fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              numberFormat.format(controller.advert.price) +
                  ' ' +
                  Environment.currencySymbol,
              style: const TextStyle(
                  color: framColor, fontWeight: FontWeight.bold, fontSize: 22),
              softWrap: true,
              overflow: TextOverflow.fade,
            )),
        const SizedBox(
          height: 10,
        ),
        Text(
          controller.advert.modifiedAt,
          softWrap: true,
          style: TextStyle(color: Colors.black.withOpacity(0.6)),
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
        controller.advert.options.length() > 0 ? _buildOptions() : SizedBox(),
        const Divider(
          height: 20,
          thickness: 0.5,
          color: Colors.grey,
        ),
        const ListTile(
          title: Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Text(controller.advert.description,
            style: const TextStyle(
              fontSize: 16,
            )),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _buildOptions() {
    return Column(children: [
      const Divider(
        height: 20,
        thickness: 0.5,
        color: Colors.grey,
      ),
      const ListTile(
        title: Text(
          'Critères',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      GridView.builder(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: controller.advert.options.length(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(AdvertOptionLabels.optionsIds[
                controller.advert.options.elementAt(index).optionId]['icon']),
            minLeadingWidth: 5,
            title: Text(
              AdvertOptionLabels.optionsIds[
                  controller.advert.options.elementAt(index).optionId]['label'],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            subtitle: Text(
              controller.advert.options.elementAt(index).value,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 6 / 2, crossAxisCount: 2),
      )
    ]);
  }

  _showGallery(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(0),
                color: Colors.white,
                child: Center(
                  child: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        controller: controller.photoViewController,
                        imageProvider: NetworkImage(
                          controller.advert.photos[index].path,
                        ),
                        maxScale: PhotoViewComputedScale.covered * 2,
                        minScale: PhotoViewComputedScale.contained * .8,
                        heroAttributes: PhotoViewHeroAttributes(
                            tag: controller.advert.photos[index].path),
                      );
                    },
                    itemCount: controller.advert.photos.length,
                    loadingBuilder: (context, event) => Center(
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          value: event == null
                              ? 0
                              : event.cumulativeBytesLoaded /
                                  event.expectedTotalBytes,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        //Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  _showSendMessageDialogContent(BuildContext context) {
    Get.dialog(
      AlertDialog(
        icon: Align(
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          alignment: Alignment.topRight,
        ),
        titlePadding: const EdgeInsets.all(0),
        iconPadding: const EdgeInsets.only(top: 5, right: 5, bottom: 0),
        insetPadding: const EdgeInsets.all(20),
        content: Form(
          key: _sendMsgFormKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .2,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: controller.messageController,
                    //initialValue: controller.messageController.value.text,
                    maxLines: 7,
                    decoration: const InputDecoration(
                      labelText: 'Votre Message',
                      labelStyle: TextStyle(
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: colorGrey),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre message';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() => FloatingActionButton(
                child: controller.isSendingMsg.isTrue
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(Icons.send),
                onPressed: () async {
                  if (_sendMsgFormKey.currentState.validate()) {
                    bool success = await controller.sendMessage();
                    if (success) {
                      Get.snackbar(
                        'Message envoyé',
                        'Votre message a été envoyé avec succès',
                        icon: const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        colorText: Colors.white,
                        backgroundColor: Colors.teal,
                      );
                      Navigator.pop(context);
                    } else {
                      Get.snackbar(
                        'Erreur',
                        'Oups une erreur s\'est produite.',
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                      );
                    }
                  }
                },
              ))
        ],
      ),
    );
  }

  _buildRelatedAds(BuildContext context) {
    if (controller.advert.relatedAdverts != null &&
        controller.advert.relatedAdverts.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(
            height: 30,
            thickness: 0.5,
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10, left: 8, right: 8),
            child: Text(
              'Ces annonces peuvent vous intéresser',
              style: TextStyle(
                fontSize: 21,
              ),
            ),
          ),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.advert.relatedAdverts.length + 1,
              itemBuilder: (BuildContext context, int index) => (index !=
                      controller.advert.relatedAdverts.length)
                  ? SizedBox(
                      width: 250,
                      child: AdvertCardGrid(
                        userInitials: 'LCO',
                        advert: controller.advert.relatedAdverts[index],
                      ),
                    )
                  : SizedBox(
                      width: 250,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRouting.similarAds, parameters: {
                            'id': controller.advert.id.toString()
                          });
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add_circle_outline,
                                size: 50,
                                color: framColor,
                              ),
                              Text(
                                'Afficher plus d\'annonces',
                                style:
                                    TextStyle(fontSize: 18, color: framColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox(
        child: Text('Nothing'),
      );
    }
  }
}
