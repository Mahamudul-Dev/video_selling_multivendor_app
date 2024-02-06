import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/models/product.model.dart';
import '../data/utils/asset_maneger.dart';

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
  final Author author;
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: onItemPressed,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
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
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.grey,
                                backgroundImage: CachedNetworkImageProvider(
                                    author.profilePic == 'N/A'
                                        ? PLACEHOLDER_PHOTO
                                        : author.profilePic ??
                                            PLACEHOLDER_PHOTO),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                width: 50,
                                child: Text(
                                  author.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6.0),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
