import 'package:afariat/config/utility.dart';

import 'package:afariat/networking/json/my_ads_json.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../config/Environment.dart';
import '../networking/json/advert_minimal_json.dart';
import 'advert_card_grid.dart';

class HorizontalAdsList extends StatelessWidget {
  final String title;
  final String showPlusTitle;
  final List<AdvertMinimalJson> advertsList;
  final Function onTapShowPlus;
  double boxHeight = 400.0;

  HorizontalAdsList({
    Key key,
    this.title,
    this.showPlusTitle,
    this.advertsList,
    this.onTapShowPlus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 360,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: advertsList.length + 1,
            itemBuilder: (BuildContext context, int index) =>
                (index != advertsList.length)
                    ? SizedBox(
                        width: 150,
                        child: AdvertCardGrid(
                          advert: advertsList[index],
                          imageWidth: 150,
                          imageHeight: 200,
                        ),
                      )
                    : (onTapShowPlus != null)
                        ? SizedBox(
                            width: 250,
                            child: InkWell(
                              onTap: onTapShowPlus,
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline,
                                      size: 50,
                                      color: framColor,
                                    ),
                                    Text(
                                      showPlusTitle,
                                      style: const TextStyle(
                                          fontSize: 18, color: framColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
          ),
        ),
      ],
    );
  }
}
