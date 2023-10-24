import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_selling_multivendor_app/themes/app_colors.dart';

import '../../constants/asset_maneger.dart';

class VideoCardTile extends StatelessWidget {
  const VideoCardTile({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.authorName,
    required this.authorPhoto,
    required this.price,
    this.onItemPressed,
    this.onAuthorPressed,
  }) : super(key: key);

  final String thumbnail;
  final String title;
  final String authorName;
  final String authorPhoto;
  final String price;
  final void Function()? onItemPressed;
  final void Function()? onAuthorPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onItemPressed,
      leading: InkWell(
          onTap: onAuthorPressed,
          child: CachedNetworkImage(imageUrl: thumbnail, fit: BoxFit.cover)),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(authorPhoto),
          ),
          Text(
            authorName,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          )
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