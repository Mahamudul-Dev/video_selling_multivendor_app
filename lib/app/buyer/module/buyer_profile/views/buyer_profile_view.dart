import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../models/profile.model.dart';
import '../../../../routes/app_pages.dart';
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
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey.shade800,
                                radius: 60,
                                backgroundImage: CachedNetworkImageProvider(
                                    snapshot.data?.data?.first.profilePic ==
                                            'N/A'
                                        ? PLACEHOLDER_PHOTO
                                        : '$BASE_URL${snapshot.data?.data?.first.profilePic}'),
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
                              const SizedBox(
                                height: 15,
                              ),
                              _activityRow(
                                  context,
                                  snapshot.data?.data?.first
                                          .favouriteItemCount ??
                                      0,
                                  snapshot.data?.data?.first
                                          .wishlistItemCount ??
                                      0,
                                  snapshot.data?.data?.first
                                          .creatorSubscriptionList?.length ??
                                      0)
                            ],
                          ),
                          Positioned(
                            right: 2,
                            top: 2,
                            child: InkWell(
                              onTap: () =>
                                  Get.toNamed(Routes.Buyer_PROFILE_EDIT),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(55, 189, 189, 189),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Edit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: Colors.grey.shade200),
                                ),
                              ),
                            ),
                          )
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
    return Column(
      children: [
        _menuTile('Payment Methods', Icons.payment_rounded, () {}, context),
        _menuTile('Contact Support', Icons.support_agent, () {}, context),
        _menuTile('Privacy Policy', Icons.security_rounded, () {}, context),
      ],
    );
  }

  // profile activity row
  Widget _activityRow(
      BuildContext context, int favCount, int wishCount, int subCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _activityItem('Favorite', favCount, () {}, context),
        _activityItem('Wishlist', wishCount, () {}, context),
        _activityItem('Subscription', subCount, () {}, context)
      ],
    );
  }

  Widget _activityItem(String buttonTitle, int count, void Function()? onTap,
      BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          controller.formatNumber(count),
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.white),
        ),
        Text(
          buttonTitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
        )
      ],
    );
  }

  Widget _menuTile(String buttonTitle, IconData icon, void Function()? onTap,
      BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: SECONDARY_APP_COLOR,
      ),
      title: Text(buttonTitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: SECONDARY_APP_COLOR)),
      trailing: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.grey.shade200,
        child: const Center(
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Colors.black54,
          ),
        ),
      ),
    );
    // InkWell(
    //   onTap: onTap,
    //   child: Material(
    //     elevation: 3,
    //     borderRadius: BorderRadius.circular(15),
    //     child: Container(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Center(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Icon(
    //               icon,
    //               color: SECONDARY_APP_COLOR,
    //             ),
    //             const SizedBox(
    //               height: 6,
    //             ),
    //             Text(
    //               buttonTitle,
    //               style: Theme.of(context).textTheme.bodyMedium,
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
