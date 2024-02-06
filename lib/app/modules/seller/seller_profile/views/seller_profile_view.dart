import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import '../../../../../themes/theme_controller.dart';
import '../../../../components/loading_animation.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../seller_dashboard/controllers/seller_dashboard_controller.dart';
import '../controllers/seller_profile_controller.dart';

class SellerProfileView extends GetView<SellerProfileController> {
  const SellerProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: controller.getSellerProfile(), builder: (context, snapshot){
      if (snapshot.hasData) {
        return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
                    title: Text(snapshot.data?.name ?? 'Unknown'),
                    centerTitle: true,
                    leading: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                          )),
                    bottom: AppBar(
                      leading: const SizedBox.shrink(),
                      leadingWidth: 0.0,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Total Videos: ${Get.find<SellerDashboardController>().formatNumber(snapshot.data?.totalVideos ?? 0)}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium,
                          ),
                          Text(
                            'Subscribers: ${Get.find<SellerDashboardController>().formatNumber(snapshot.data?.creatorSubscriptionList?.length ?? 0)}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () => controller.copySellerIdToClipboard(
                              context,
                              snapshot.data?.userName ?? ''),
                          icon: const Icon(
                            Icons.copy_rounded,
                          )),
                      
                    ],
                  ),

            SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                              .data?.profilePic !=
                                          'N/A'
                                      ? '$BASE_URL${snapshot.data?.profilePic}'
                                      : PLACEHOLDER_PHOTO,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Username: ${snapshot.data?.userName}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'From: ${snapshot.data?.country}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'City: ${snapshot.data?.city}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Business Inquery: ${snapshot.data?.email}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RatingBar.builder(
                                        initialRating: 4.5,
                                        unratedColor: Colors.grey,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20,
                                        ignoreGestures: true,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, index) {
                                          return const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          );
                                        },
                                        onRatingUpdate: (value) {}),
                                    Row(
                                      children: [
                                        Text(
                                          '4.5',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(color: Colors.amber),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Ratings',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(color: Colors.amber),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('About',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            snapshot.data?.about != ''
                                ? snapshot.data!.about!
                                : 'No Details Available',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall,
                          )
                        ],
                      ),
                    ),
                  ),
            SliverToBoxAdapter(child: _menuBar(context),)
          ],
        ),
      );
    
      }  

      return const Scaffold(
        body: LoadingAnimation(color: Colors.white,),
      );
    });
  }

  Widget _menuBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text('Dark Mode', style: Theme.of(context).textTheme.labelMedium,),
          leading: const Icon(Icons.style),
          trailing: Obx(
                () => Switch(
                  thumbIcon: MaterialStatePropertyAll(Get.find<ThemeController>().isLightMode.value ? const Icon(Icons.sunny) : const Icon(Icons.nightlight_round)),
                  value: Get.find<ThemeController>().isLightMode.value,
                  onChanged: (value) => Get.find<ThemeController>().toggleTheme(),
                ),
              ),
        ),
        _menuTile('Contact Support', true, Icons.support_agent, () {Get.toNamed(Routes.SUPPORT_CHAT);}, context),
        _menuTile('Privacy Policy', true, Icons.security_rounded, () {}, context),
        _menuTile('Log Out', false, Icons.logout, ()=> controller.logout(), context)
      ],
    );
  }


  Widget _menuTile(String buttonTitle, bool enableTrailer, IconData icon, void Function()? onTap,
      BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon
      ),
      title: Text(buttonTitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium),
      trailing: enableTrailer ? const CircleAvatar(
        radius: 10,
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 13
          ),
        ),
      ) : const SizedBox.shrink(),
    );
  }
}
