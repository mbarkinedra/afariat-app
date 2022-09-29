import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/utility.dart';
import '../mywidget/custom_button_1.dart';
import '../mywidget/search_field_appbar.dart';
import '../networking/json/adverts_json.dart';
import 'home_view_controller.dart';
import '../../mywidget/advert_card_grid.dart';

class HomeView extends GetWidget<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  expandedHeight: 80,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Align(
                        alignment: Alignment.center,
                        child: Image.network(
                          'https://lecoinoccasion.fr/build/images/lecoinoccasion.fr/logo.ad317657.webp',
                          fit: BoxFit.cover,
                          height: 26,
                        )),
                    titlePadding: EdgeInsets.only(top: 60),
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
                padding: EdgeInsets.all(10),
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
            ]))));
  }

  _topCategories(BuildContext context) {
    return SizedBox(
        height: 120,
        child: ListView.builder(
          itemBuilder: (BuildContext, index) {
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
                          padding: EdgeInsets.only(bottom: 5),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    controller.topCategories[index]['label'],
                                    style: TextStyle(
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
                  margin: EdgeInsets.all(5),
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
}
