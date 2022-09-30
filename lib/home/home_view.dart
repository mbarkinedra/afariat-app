import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_config.dart';
import '../config/app_routing.dart';
import '../config/utility.dart';
import '../mywidget/custom_button_1.dart';
import '../mywidget/search_field_appbar.dart';
import '../networking/json/adverts_json.dart';
import 'drawer_view.dart';
import 'home_view_controller.dart';
import '../../mywidget/advert_card_grid.dart';

class HomeView extends GetWidget<HomeViewController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var appConfig = AppConfig.of(context);
    return Scaffold(
      key: scaffoldKey,
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: true,
                pinned: false,
                expandedHeight: 80,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () => scaffoldKey.currentState.openDrawer(),
                          child: const Icon(
                            Icons.menu,
                            color: colorGrey,
                            size: 22,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/" + appConfig.appName + "/logo.png",
                            width: 100,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(AppRouting.notifications);
                          },
                          child: _buildNotifications(),
                        ),
                      ),
                    ],
                  ),
                  titlePadding: const EdgeInsets.only(top: 60),
                ),
              ),
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                expandedHeight: 60,
                title: Padding(
                  child: SearchFieldAppbar(),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 10, top: 10),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
              child: Column(children: [
            const Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
              child: Text(
                'Top catégories',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            _topCategories(context),
            _buildLastAds(context),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton1(
                function: () async {
                  Get.toNamed('/search');
                },
                labcolor: Colors.white,
                height: 40,
                width: context.mediaQuery.size.width * .8,
                label: "Toutes les annonces",
                btcolor: buttonColor,
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ]))),
      drawer: DrawerView(
        controller: controller.drawerController,
      ),
    );
  }

  _topCategories(BuildContext context) {
    return SizedBox(
        height: 120,
        child: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return InkWell(
                onTap: () => controller
                    .selectCategory(controller.topCategories[index]['id']),
                child: Card(
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/common/categories/" +
                            controller.topCategories[index]['image']),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    controller.topCategories[index]['label'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )))),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(5),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ));
          },
          itemCount: controller.topCategories.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.horizontal,
        ));
  }

  _buildLastAds(BuildContext context) {
    return FutureBuilder<AdvertListJson>(
        future: controller.fetchLastAds(),
        builder: (context, AsyncSnapshot<AdvertListJson> snapshot) {
          if (snapshot.hasData) {
            return Column(children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                child: Text(
                  'Dernières annonces',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              controller.advertListJson.adverts() != null
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.advertListJson.adverts().length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.6,
                              crossAxisCount: 2,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0),
                      itemBuilder: (context, index) => AdvertCardGrid(
                        advert: controller.advertListJson.adverts()[index],
                        userInitials: 'LC',
                      ),
                      //scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                    )
                  : const SizedBox(),
            ]);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  _buildNotifications() {
    return Padding(
      padding: const EdgeInsets.only(right: 1),
      child: Stack(
        children: [
          const Icon(
            Icons.notifications,
            color: colorGrey,
            size: 22,
          ),
          if (controller.notificationController.notifCount.value > 0)
            Positioned(
              left: 10,
              top: 0,
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: Center(
                  child: Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(1),
                      child: Text(
                        controller.notificationController.notifCount.value < 10
                            ? controller.notificationController.notifCount.value
                                .toString()
                            : "9+",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ),
                  ),
                ),
                height: 14,
                width: 14,
              ),
            )
        ],
      ),
    );
  }
}
