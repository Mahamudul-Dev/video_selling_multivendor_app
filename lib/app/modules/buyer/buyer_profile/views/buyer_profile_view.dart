import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../../../themes/theme_controller.dart';
import '../../../../data/models/profile.model.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../routes/app_pages.dart';
import '../../../../data/utils/constants.dart';
import '../../../../components/loading_animation.dart';
import '../controllers/buyer_profile_controller.dart';

class BuyerProfileView extends GetView<BuyerProfileController> {
  const BuyerProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,

        actions: [
          Obx(
                () => Switch(
                  thumbIcon: MaterialStatePropertyAll(Get.find<ThemeController>().isDarkMode.value ? const Icon(Icons.nightlight_round) : const Icon(Icons.sunny)),
                  value: Get.find<ThemeController>().isDarkMode.value,
                  onChanged: (value) => Get.find<ThemeController>().toggleTheme(),
                ),
              ),
        ],
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
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.onTertiary,
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
                                    .titleLarge?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                snapshot.data?.data?.first.userName ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground),
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
                                    color: Theme.of(context).colorScheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Edit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)
                        ),
                        child: Text(
                          'Switch to Seller',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                        onPressed: () => controller.logout(),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.error)
                        ),
                        child: Text(
                          'Logout',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge?.copyWith(color: Theme.of(context).colorScheme.onError)
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
        _menuTile('Favorite List', FontAwesomeIcons.heartCircleCheck, 20, () => Get.toNamed(Routes.FAVORITE_LIST), context),
        _menuTile('Wishlist', Icons.label_rounded, null, () => Get.toNamed(Routes.WISH_LIST), context),
        _menuTile('Subscribed Creators', Icons.thumb_up_alt_rounded, null, () => Get.toNamed(Routes.SUBSCRIBED_CREATOR_LIST), context),
        _menuTile('Change Methods', Icons.payment_rounded, null, () {}, context),
        _menuTile('Contact Support', Icons.support_agent, null, () => Get.toNamed(Routes.SUPPORT_CHAT), context),
        _menuTile('Privacy Policy', Icons.security_rounded, null, () {}, context),
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
              .labelLarge?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        Text(
          buttonTitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        )
      ],
    );
  }

  Widget _menuTile(String buttonTitle, IconData icon, double? size, void Function()? onTap,
      BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: size,
      ),
      title: Text(buttonTitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium),
      trailing: CircleAvatar(
        radius: 15,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
