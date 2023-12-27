import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/utils/asset_maneger.dart';

class TopProfileComponent extends StatelessWidget {
  const TopProfileComponent({
    Key? key,
    required this.name,
    this.profilePhoto,
    required this.subTitle,
    this.subscriberCount,
    this.totalVideosCount,
    this.onTap
  }) : super(key: key);

  final String name;
  final String? profilePhoto;
  final String? subTitle;
  final String? subscriberCount;
  final String? totalVideosCount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: 10.0,
      leading: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.10,
        backgroundImage:
            CachedNetworkImageProvider(profilePhoto ?? PLACEHOLDER_PHOTO),
      ),
      title: Text(
        name,
        style: Theme.of(context)
            .textTheme
            .labelLarge,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Subscriber: $subscriberCount',
            style: Theme.of(context)
                .textTheme
                .labelSmall,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            'Total Videos: $totalVideosCount',
            style: Theme.of(context)
                .textTheme
                .labelSmall,
          ),
        ],
      ),
    );
  }
}
