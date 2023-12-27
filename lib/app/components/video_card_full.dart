import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/models/product.model.dart';
import '../data/utils/asset_maneger.dart';

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
  final String price;
  final Author author;
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
                  color: Theme.of(context).colorScheme.background,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(thumbnail),
                      fit: BoxFit.cover)),
            ),
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: onAuthorPressed,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      backgroundImage: CachedNetworkImageProvider(
                          author.profilePic == 'N/A'
                              ? PLACEHOLDER_PHOTO
                              : author.profilePic ?? PLACEHOLDER_PHOTO),
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
                            Text(author.name ?? '',
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
                                      Text('\$$price',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                  ElevatedButton(
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
