import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../config/utility.dart';
import 'advert_details_viewcontroller.dart';

class AdvertDetailsView extends GetWidget<AdvertDetailsViewController> {
  const AdvertDetailsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        key: controller.key,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          title: const Text(
            "Annonce détaillée",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          leading: IconButton(
              icon: const Icon(
                //
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: SingleChildScrollView(
          child: GetBuilder<AdvertDetailsViewController>(builder: (logic) {
            return Obx(() => logic.loading.isTrue
                ? SizedBox(
                    width: _size.width,
                    height: _size.height * 0.8,
                    child: const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        _buildCarousel(context),
                        //_buildAdvert(),
                      ],
                    ),
                  ));
          }),
        ));
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
                      child: Image.network(
                        item.path,
                        height: _size.height * .25,
                        width: _size.width * .8,
                        fit: BoxFit.fill,
                      ),
                    ))
                .toList(),
          )
        : controller.advert.photos.isNotEmpty
            ? InkWell(
                onTap: () {
                  _showGallery(context);
                },
                child: Container(
                  height: _size.height * .3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(controller.advert.photos[0].path),
                          fit: BoxFit.fill)),
                ),
              )
            : const SizedBox();
  }

  _buildAdvert() {}

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
        return SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(10),
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
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        //Navigator.pop(context);
                      },
                      child: Container(
                          color: Colors.grey[100],
                          child: const Icon(
                            Icons.close,
                            color: framColor,
                            size: 30,
                          ))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
