import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_selling_multivendor_app/app/buyer/components/shimmer_effect.dart';
import 'package:video_selling_multivendor_app/app/utils/constants.dart';

import '../../../themes/app_colors.dart';
import '../../models/profile.model.dart';

class VideoCardFull extends StatelessWidget {
  const VideoCardFull(
      {super.key,
      required this.thumbnail,
      required this.title,
      required this.author,
      required this.price,
      this.onCartPressed,
      this.onItemPressed,
      this.onAuthorPressed});

  final String thumbnail;
  final String title;
  final Future<Profile?> Function() author;
  final String price;
  final void Function()? onCartPressed;
  final void Function()? onItemPressed;
  final void Function()? onAuthorPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onItemPressed,
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(thumbnail),
                      fit: BoxFit.cover)),
            ),
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(color: Colors.white70),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: onAuthorPressed,
                    child: FutureBuilder(
                        future: author(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey,
                              backgroundImage: CachedNetworkImageProvider(
                                  snapshot.data?.profilePic == 'N/A'
                                      ? PLACEHOLDER_PHOTO
                                      : snapshot.data?.profilePic ??
                                          PLACEHOLDER_PHOTO),
                            );
                          }
                          return const ShimmerEffect.circuller(
                            width: 25,
                            height: 25,
                          );
                        }),
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: onItemPressed,
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            FutureBuilder(
                                future: author(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data?.name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall);
                                  }
                                  return const ShimmerEffect.rectangular(
                                      height: 20);
                                }),
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('\$$price',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                  ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  SECONDARY_APP_COLOR)),
                                      onPressed: onCartPressed,
                                      child: Text(
                                        'Add to cart',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.white),
                                      ))
                                ],
                              ),
                            )
                          ]),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
