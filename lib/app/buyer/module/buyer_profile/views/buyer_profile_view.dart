import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../constants/utils.dart';
import '../controllers/buyer_profile_controller.dart';

class BuyerProfileView extends GetView<BuyerProfileController> {
  const BuyerProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  color: SECONDARY_APP_COLOR,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.2,
                    backgroundImage:
                        const CachedNetworkImageProvider(PLACEHOLDER_PHOTO),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Mahamudul Hasan',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    '@mahamudul.dev',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          _menuBar()
        ],
      ),
    );
  }

// menu item
  Widget _menuBar() {
    return Row(
      children: [_menuButton('Favorite', CupertinoIcons.heart, () {})],
    );
  }

  Widget _menuButton(
      String buttonTitle, IconData icon, void Function()? onTap) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: SECONDARY_APP_COLOR,
            ),
            const SizedBox(
              height: 6,
            ),
            const Text('Favorite')
          ],
        ),
      ),
    );
  }
}
