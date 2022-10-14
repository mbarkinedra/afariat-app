import 'package:afariat/home/search/similar_adverts_viewcontroller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../config/utility.dart';
import '../../mywidget/advert_card_grid.dart';
import '../../mywidget/advert_card_list.dart';
import '../../networking/json/advert_minimal_json.dart';

class SimilarAdvertsView extends GetWidget<SimilarAdvertsViewController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  SimilarAdvertsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    //define it here because of the shit of: ScrollController attached to multiple scroll views
    //controller.scrollController = ScrollController();
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity > 0) {
            Get.back();
          }
        },
        child: SafeArea(
          child: FutureBuilder(
            future: controller.fetchInitialData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return CustomScrollView(
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    Obx(
                      () => SliverAppBar(
                        pinned: false,
                        floating: false,
                        snap: false,
                        forceElevated: false,
                        elevation: 0,
                        expandedHeight:
                            SimilarAdvertsViewController.expandedHeight,
                        backgroundColor: Colors.white,
                        flexibleSpace: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.center,
                              colors: [
                                Color(0xFFFFCCBC),
                                Colors.white,
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: controller.imgHeight.value,
                                width: controller.imgWidth.value,
                                child:
                                Card(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1000),
                                    side: const BorderSide(
                                        width: 3, color: Colors.white),
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10000.0),
                                    child: CachedNetworkImage(
                                      imageUrl: controller.advert.defaultPhoto,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          const Align(
                                              alignment: Alignment.center,
                                              child:
                                                  CupertinoActivityIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/images/common/no-image.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 5, right: 5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    controller.advert.title.toUpperCase(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => SliverAppBar(
                        // show and hide SliverAppBar Title
                        title: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            !controller.isSliverAppBarCollapsed.value
                                ? const Icon(
                                    Icons.ad_units_outlined,
                                    color: Colors.black54,
                                  )
                                : SizedBox(),
                            const Text(
                              'Annonces similaires',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        centerTitle: !controller.isSliverAppBarCollapsed.value,
                        pinned: true,
                        snap: false,
                        floating: false,
                        forceElevated: controller.isSliverAppBarCollapsed.value,
                        elevation:
                            controller.isSliverAppBarCollapsed.value ? 20 : 0,
                        automaticallyImplyLeading:
                            controller.isSliverAppBarCollapsed.value,
                        backgroundColor: Colors.white,
                        leading: controller.isSliverAppBarCollapsed.value
                            ? IconButton(
                                icon: const Icon(
                                  //
                                  Icons.arrow_back_ios,
                                  color: framColor,
                                ),
                                onPressed: () {
                                  Get.back();
                                })
                            : null,
                      ),
                    ),
                    // Next, create a SliverList
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    _buildGrid(context),
                    SliverToBoxAdapter(
                      child: Obx(() => controller.isLoadingMore.value != false
                          ? const Center(child: CupertinoActivityIndicator())
                          : const SizedBox.shrink()),
                    ),
                    SliverToBoxAdapter(
                      child: Obx(() => controller.noMoreResults.value != false
                          ? const Center(
                              child: Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 10),
                              child: Text(
                                'Plus d\'annonces similaires. Retourner sur la page de recherche pour plus de résultats',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: colorGrey),
                              ),
                            ))
                          : const SizedBox.shrink()),
                    ),
                  ],
                );
              } else {
                return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  _buildGrid(context) {
    Size _size = MediaQuery.of(context).size;
    return Obx(() => controller.isGrid.value
        ? PagedSliverGrid<int, AdvertMinimalJson>(
            pagingController: controller.pagingController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 100 / 150,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            builderDelegate: PagedChildBuilderDelegate<AdvertMinimalJson>(
              animateTransitions: true,
              itemBuilder: (context, item, index) => AdvertCardGrid(
                advert: item,
                userInitials: 'LCO',
              ),
            ),
          )
        : PagedSliverList<int, AdvertMinimalJson>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<AdvertMinimalJson>(
              animateTransitions: true,
              itemBuilder: (context, item, index) =>
                  AdvertCardList(advert: item, userInitials: 'LCO'),
            ),
          ));
  }
}
