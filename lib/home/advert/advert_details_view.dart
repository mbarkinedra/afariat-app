import 'package:afariat/config/app_routing.dart';
import 'package:afariat/home/advert/report_advert_viewcontroller.dart';
import 'package:afariat/networking/json/advert_details_json.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../Common/popup.dart';
import '../../config/Environment.dart';
import '../../config/utility.dart';
import '../../model/advert_option_labels.dart';
import '../../mywidget/advert_card_grid.dart';
import '../../mywidget/favorite_icon.dart';
import '../../mywidget/horizontal_ads_list.dart';
import '../../mywidget/user_advert_widget.dart';
import '../../persistent_tab_manager.dart';
import '../../storage/AccountInfoStorage.dart';
import '../tap_profile/favorite/favorite_view_controller.dart';
import 'advert_details_viewcontroller.dart';

class AdvertDetailsView extends GetWidget<AdvertDetailsViewController> {
  AdvertDetailsView({Key key}) : super(key: key);
  final numberFormat = NumberFormat("###,##0", Environment.locale);
  final _sendMsgFormKey = GlobalKey<FormState>();
  FavoriteViewController favController = Get.find<FavoriteViewController>();

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
        title: Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Annonce détaillée",
                    style: TextStyle(color: colorText, fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => controller.loading.isTrue
                        ? const SizedBox()
                        : controller.advert != null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () => _onShare(context),
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.grey.shade800,
                                      size: 24.0,
                                      semanticLabel: 'Partager l\'annonce',
                                    ),
                                  ),
                                  AdvertFavoriteIcon(
                                    iconShadow: false,
                                    offIconColor: Colors.grey,
                                    onIconColor: Colors.black87,
                                    onLikedIconColor: Colors.pink,
                                    iconSize: 28,
                                    advertId: int.parse(controller.advertId),
                                    isLoggedIn: Get.find<AccountInfoStorage>()
                                        .isLoggedIn(),
                                    onAdd: () =>
                                        favController.addAdvertToFavorites(
                                            int.parse(controller.advertId)),
                                    onDelete: () =>
                                        favController.removeAdvertFromFavorite(
                                            int.parse(controller.advertId)),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildMoreMenuAction(context),
                ],
              ),
            ),
          ],
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
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity > 0) {
            Get.back();
          }
        },
        child: SingleChildScrollView(
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
                        const Divider(
                          height: 30,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        _buildUser(),
                        SizedBox(
                          height: 30,
                        ),
                        (controller.advert.userSameAdverts != null &&
                                controller.advert.userSameAdverts.isNotEmpty)
                            ? HorizontalAdsList(
                                title: 'Autres annonces de ' +
                                    controller.advert.user.firstName,
                                advertsList: controller.advert.userSameAdverts,
                              )
                            : const SizedBox(),
                        const Divider(
                          height: 60,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        (controller.advert.relatedAdverts != null &&
                                controller.advert.relatedAdverts.isNotEmpty)
                            ? HorizontalAdsList(
                                title: 'Ces annonces peuvent vous intéresser',
                                advertsList: controller.advert.relatedAdverts,
                                showPlusTitle: 'Afficher plus d\'annonces',
                                onTapShowPlus: () => Get.toNamed(
                                  AppRouting.similarAds,
                                  parameters: {
                                    'id': controller.advert.id.toString(),
                                  },
                                ),
                              )
                            : const SizedBox(),
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
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Obx(
          () => controller.loading.isTrue
              ? const Center(child: CircularProgressIndicator())
              : Get.find<AccountInfoStorage>().isLoggedIn()
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.advert.showPhoneNumber
                            ? Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  child: const Padding(
                                    child: Icon(Icons.call),
                                    padding: EdgeInsets.all(12),
                                  ),
                                  onPressed: () {
                                    controller.makeCallOrSms(
                                        controller.advert.mobilePhoneNumber,
                                        'tel');
                                  },
                                  style: OutlinedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      side: const BorderSide(
                                          width: 1, color: Colors.grey)),
                                ),
                              )
                            : const SizedBox(),
                        Expanded(
                          flex: 1,
                          child: FloatingActionButton(
                            child: const Icon(Icons.chat),
                            tooltip: 'Envoyer un message',
                            onPressed: () =>
                                _showSendMessageDialogContent(context),
                          ),
                        ),
                        controller.advert.showPhoneNumber
                            ? Expanded(
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
                                        controller.advert.mobilePhoneNumber,
                                        'sms');
                                  },
                                  style: OutlinedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      side: const BorderSide(
                                          width: 1, color: Colors.grey)),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey.shade200),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black54),
                          ),
                          onPressed: () => Popup.showAccessDenied(context,
                              'Vous devez être connecté pour accéder aux informations de contact de l\'annonceur.'),
                          icon: const Icon(Icons
                              .chat_rounded), //icon data for elevated button
                          label:
                              const Text("Contacter l'annonceur"), //label text
                        )
                      ],
                    ),
        ),
      ),
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
              disableCenter: false,
              autoPlayCurve: Curve()
            ),
            items: controller.advert.photos
                .map(
                  (item) => InkWell(
                    onTap: () {
                      _showGallery(context);
                    },
                    child: CachedNetworkImage(
                      imageUrl: item.path,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => const Align(
                        alignment: Alignment.center,
                        child: CupertinoActivityIndicator(),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/common/no-image.jpg",
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
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
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _buildUser() {
    //TODO: if not registered

    return Column(
      children: [
        UserAdvertWidget(
          user: controller.advert.user,
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
          Map<String, dynamic> optionLabel = AdvertOptionLabels
              .optionsIds[controller.advert.options.elementAt(index).optionId];
          String suffix = optionLabel['suffix'] ?? '';
          return ListTile(
            leading: Icon(optionLabel['icon']),
            minLeadingWidth: 5,
            title: Text(
              optionLabel['label'],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            subtitle: Text(
              controller.advert.options.elementAt(index).value + ' ' + suffix,
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

  _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox;
    String text =
        'J\'ai trouvé une annonce qui devrait vous intéresser sur Lecoinoccasion : ' +
            controller.advert.shortUrl;
    await Share.share(
      text,
      subject: controller.advert.title,
      sharePositionOrigin:
          box != null ? box.localToGlobal(Offset.zero) & box.size : null,
    );
  }

  _buildMoreMenuAction(BuildContext context) {
    List<PopupMenuItem<String>> menuItems = [
      PopupMenuItem(
        child: ListTile(
          title: const Text('Signaler cette annonce'),
          leading: const Icon(Icons.report),
          contentPadding: EdgeInsets.all(0),
          onTap: () {
            Navigator.pop(context);
            //set the advert in the report ad controller before showing the report view
            Get.find<ReportAdvertViewController>().advert = controller.advert;
            Get.toNamed(AppRouting.adReport);
          },
        ),
      ),
    ];

    return PopupMenuButton(
      padding: const EdgeInsets.all(0),
      itemBuilder: (context) => menuItems,
    );
  }
}
