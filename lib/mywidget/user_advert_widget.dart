import 'package:afariat/config/utility.dart';

import 'package:afariat/networking/json/my_ads_json.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../config/Environment.dart';
import '../config/app_config.dart';
import '../networking/json/user_minimal_json.dart';

class UserAdvertWidget extends StatelessWidget {
  final UserMinimalJson user;

  const UserAdvertWidget({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 60,
                width: 60,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000),
                    side: const BorderSide(width: 0.5, color: Colors.white),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10000.0),
                    child: user.photo != null
                        ? CachedNetworkImage(
                            imageUrl: user.photo,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => const Align(
                                    alignment: Alignment.center,
                                    child: CupertinoActivityIndicator()),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/common/no-user-photo.webp",
                              fit: BoxFit.fill,
                            ),
                          )
                        : Image.asset(
                            "assets/images/common/no-user-photo.webp",
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Align(
                alignment: Alignment.centerRight,
                child: Card(
                  elevation: 0.5,
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      user.type == 0 ? 'PART' : 'PRO',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            user.firstName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          ' ' +
              user.totalAdsCount.toString() +
              ' annonce' +
              (user.totalAdsCount > 1 ? 's' : ''),
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.grey.shade700,
              size: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              user.city.name +
                  (user.city.codeInsee != null
                      ? ' (' + user.city.codeInsee + ')'
                      : ''),
              style: TextStyle(color: Colors.grey.shade800),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.account_circle,
              color: Colors.grey.shade700,
              size: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Membre depuis ' + user.memberSince(),
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
          ],
        )
      ],
    );
  }
}
