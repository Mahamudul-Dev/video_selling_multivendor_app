import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';

class VideoCardFull extends StatelessWidget {
  const VideoCardFull(
      {super.key,
      required this.thumbnail,
      required this.title,
      required this.authorName,
      required this.authorPhoto,
      required this.price,
      this.onCartPressed,
      this.onItemPressed,
      this.onAuthorPressed});

  final String thumbnail;
  final String title;
  final String authorName;
  final String authorPhoto;
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
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white70),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: onAuthorPressed,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      backgroundImage: CachedNetworkImageProvider(authorPhoto),
                    ),
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
                            Text(authorName,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall),
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                          Icons.currency_bitcoin_rounded),
                                      Text(price,
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
