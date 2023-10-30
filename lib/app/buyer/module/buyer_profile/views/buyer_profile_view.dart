import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../models/profile.model.dart';
import '../../../../utils/constants.dart';
import '../../../components/loading_animation.dart';
import '../controllers/buyer_profile_controller.dart';

class BuyerProfileView extends GetView<BuyerProfileController> {
  const BuyerProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: FutureBuilder<ProfileModel?>(
          future: controller.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: const BoxDecoration(
                          color: SECONDARY_APP_COLOR,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.2,
                            backgroundImage: CachedNetworkImageProvider(
                                snapshot.data?.data?.first.profilePic == 'N/A'
                                    ? PLACEHOLDER_PHOTO
                                    : snapshot.data?.data?.first.profilePic ??
                                        PLACEHOLDER_PHOTO),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            snapshot.data?.data?.first.name ?? '',
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
                            snapshot.data?.data?.first.userName ?? '',
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
                  _menuBar(context),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        child: Text(
                          'Switch to Seller',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: SECONDARY_APP_COLOR),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(SECONDARY_APP_COLOR)),
                        child: Text(
                          'Logout',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.white),
                        )),
                  )
                ],
              );
            }
            return const LoadingAnimation();
          }),
    );
  }

// menu item
  Widget _menuBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _menuButton('Favorite', CupertinoIcons.heart, () {}, context),
        _menuButton('Wishlist', CupertinoIcons.shopping_cart, () {}, context),
        _menuButton('Interest', CupertinoIcons.bookmark, () {}, context)
      ],
    );
  }

  Widget _menuButton(String buttonTitle, IconData icon, void Function()? onTap,
      BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10.0),
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
                Text(
                  buttonTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
