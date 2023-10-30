import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_selling_multivendor_app/app/utils/constants.dart';
import 'package:video_selling_multivendor_app/themes/app_colors.dart';

import '../../models/profile.model.dart';
import 'shimmer_effect.dart';

class VideoCardTile extends StatelessWidget {
  const VideoCardTile({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.author,
    required this.price,
    this.onItemPressed,
    this.onAuthorPressed,
  }) : super(key: key);

  final String thumbnail;
  final String title;
  final Future<Profile?> Function() author;
  final String price;
  final void Function()? onItemPressed;
  final void Function()? onAuthorPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onItemPressed,
      leading: InkWell(
          onTap: onAuthorPressed,
          child: CachedNetworkImage(
            imageUrl: thumbnail,
            fit: BoxFit.fitWidth,
            width: 80,
            height: 60,
          )),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
        maxLines: 2,
      ),
      subtitle: Row(
        children: [
          FutureBuilder(
              future: author(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(
                        snapshot.data?.profilePic == 'N/A'
                            ? PLACEHOLDER_PHOTO
                            : snapshot.data?.profilePic ?? PLACEHOLDER_PHOTO),
                  );
                }
                return const ShimmerEffect.circuller(
                  width: 25,
                  height: 25,
                );
              }),
          FutureBuilder(
              future: author(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall);
                }
                return const ShimmerEffect.rectangular(
                  height: 20,
                  width: 50,
                );
              }),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: SECONDARY_APP_COLOR,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          price == "00" ? "Free" : '\$$price',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}


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