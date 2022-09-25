import 'package:afariat/mywidget/asbtract_advert_card.dart';
import 'package:flutter/material.dart';
import '../config/Environment.dart';
import '../config/utility.dart';
import '../networking/json/adverts_json.dart';

class AdvertCardGrid extends AbstractAdvertCard {
  AdvertCardGrid({Key key, AdvertJson advert, String userInitials})
      : super(key: key, advert: advert, userInitials: userInitials);

  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          Expanded(
            flex: 1,
            child: Container(
              //height: size.height * .2,
              child: advert.photo != null
                  ? Image.network(
                      advert.photo,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      "assets/images/common/no-image.jpg",
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          ListTile(
            minLeadingWidth: 10,
            leading: CircleAvatar(
              maxRadius: 12,
              backgroundColor: Colors.blueGrey.shade50,
              child: Text(
                userInitials,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900),
              ),
            ),
            title: Text(
              advert.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
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
                        advert.town.name,
                        softWrap: true,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: Colors.grey,
                    size: 14,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        advert.modifiedAt,
                        softWrap: true,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          //const Divider(thickness: 0.5),
          Row(children: [
            Expanded(
              flex: 8,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    numberFormat.format(advert.price) +
                        ' ' +
                        Environment.currencySymbol,
                    style: const TextStyle(
                        color: framColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )),
            ),
            const Expanded(flex: 2, child: Icon(Icons.favorite_outline_rounded))
          ]),
          const SizedBox(
            height: 10,
          ),
        ]));
  }
}
