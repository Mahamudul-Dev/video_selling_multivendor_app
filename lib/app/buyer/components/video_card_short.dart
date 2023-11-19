import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_selling_multivendor_app/app/buyer/components/shimmer_effect.dart';
import 'package:video_selling_multivendor_app/app/utils/constants.dart';

import '../../../themes/app_colors.dart';
import '../../models/profile.model.dart';

class VideoCardShort extends StatelessWidget {
  const VideoCardShort({
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Material(
        elevation: 3,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: InkWell(
                  onTap: onItemPressed,
                  child: CachedNetworkImage(
                    imageUrl: thumbnail,
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: onItemPressed,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: onAuthorPressed,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FutureBuilder(
                                  future: author(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return CircleAvatar(
                                        radius: 13,
                                        backgroundColor: Colors.grey,
                                        backgroundImage:
                                            CachedNetworkImageProvider(snapshot
                                                        .data?.profilePic ==
                                                    'N/A'
                                                ? PLACEHOLDER_PHOTO
                                                : snapshot.data?.profilePic ??
                                                    PLACEHOLDER_PHOTO),
                                      );
                                    }
                                    return const ShimmerEffect.circuller(
                                        width: 10, height: 10);
                                  }),
                              const SizedBox(
                                width: 4,
                              ),
                              FutureBuilder(
                                  future: author(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return SizedBox(
                                        width: 50,
                                        child: Text(
                                          snapshot.data?.name ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      );
                                    }
                                    return const ShimmerEffect.rectangular(
                                      height: 10,
                                      width: 40,
                                    );
                                  })
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              color: SECONDARY_APP_COLOR,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
