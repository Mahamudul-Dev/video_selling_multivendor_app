import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


import '../data/models/product.model.dart';
import '../data/utils/asset_maneger.dart';

class VideoCardTile extends StatelessWidget {
  const VideoCardTile({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.author,
    required this.price,
    this.initialRating,
    this.views,
    this.onItemPressed,
    this.onAuthorPressed,
  }) : super(key: key);

  final String thumbnail;
  final String title;
  final Author author;
  final String price;
  final double? initialRating;
  final int? views;
  final void Function()? onItemPressed;
  final void Function()? onAuthorPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemPressed,
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.33,
                child: InkWell(
                    onTap: onItemPressed,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)),
                      child: CachedNetworkImage(
                          imageUrl: thumbnail, fit: BoxFit.fitHeight),
                    )),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                        initialRating: initialRating ?? 0,
                        unratedColor: Colors.grey,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 15,
                        ignoreGestures: true,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, index) {
                          return const Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        onRatingUpdate: (value) {}),
                    InkWell(
                      child: Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        InkWell(
                          onTap: onAuthorPressed,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.grey,
                            backgroundImage: CachedNetworkImageProvider(
                                author.profilePic == 'N/A'
                                    ? PLACEHOLDER_PHOTO
                                    : author.profilePic ?? PLACEHOLDER_PHOTO),
                          ),
                        ),
                        InkWell(
                          onTap: onAuthorPressed,
                          child: Text(author.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.remove_red_eye_rounded,
                              color: Colors.grey,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '$views',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            price == "00" ? "Free" : '\$$price',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ListTile(
//   onTap: onItemPressed,
//   leading: InkWell(
//       onTap: onAuthorPressed,
//       child: CachedNetworkImage(
//         imageUrl: thumbnail,
//         fit: BoxFit.cover,
//         width: 120,
//         height: 100,
//         color: Colors.green,
//       )),
//   title: Text(
//     title,
//     style: Theme.of(context)
//         .textTheme
//         .titleSmall
//         ?.copyWith(color: SECONDARY_APP_COLOR),
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//   ),
//   subtitle: Row(
//     children: [
//       CircleAvatar(
//                 radius: 10,
//                 backgroundColor: Colors.grey,
//                 backgroundImage: CachedNetworkImageProvider(
//                     author.profilePic == 'N/A'
//                         ? PLACEHOLDER_PHOTO
//                         : author.profilePic ?? PLACEHOLDER_PHOTO),
//               ),
//       Text(author.name ?? '',
//                   overflow: TextOverflow.ellipsis,
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodySmall
//                       ?.copyWith(color: SECONDARY_APP_COLOR)),
//     ],
//   ),
// ),

// SizedBox(
//               height: 50,
//               width: 50,
//               child: DotLottieLoader.fromAsset(FIRE_ANIM,
//                   frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
//                 if (dotlottie != null) {
//                   return Lottie.memory(dotlottie.animations.values.single);
//                 } else {
//                   return Container();
//                 }
//               }),
//             ),
