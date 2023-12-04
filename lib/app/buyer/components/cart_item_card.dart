import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/data/utils/asset_maneger.dart';
import 'package:video_selling_multivendor_app/app/data/utils/constants.dart';

import '../../../themes/app_colors.dart';
import '../../data/models/product.model.dart';
import '../../routes/app_pages.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key? key,
    required this.productName,
    required this.author,
    required this.productImage,
    required this.price,
    this.onRemovePress,
    this.onProductPress,
  }) : super(key: key);

  final String productName;
  final Author author;
  final String productImage;
  final String price;
  final void Function()? onRemovePress;
  final void Function()? onProductPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 24,
            offset: Offset(0, 11),
            spreadRadius: 0,
          )
        ],
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: onProductPress,
                child: Image(
                  image: CachedNetworkImageProvider(productImage),
                  fit: BoxFit.fitWidth,
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                            child: InkWell(
                          onTap: onProductPress,
                          child: Text(
                            productName,
                            style: Theme.of(context).textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    InkWell(
                      onTap: ()=>Get.toNamed(Routes.AUTHOR_PROFILE, arguments: {'id':author.id}),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.grey,
                            backgroundImage: CachedNetworkImageProvider(author.profilePic != 'N/A' ? BASE_URL+author.profilePic! : PLACEHOLDER_PHOTO),
                          ),
                          Flexible(
                              child: Text(
                                        author.name ?? 'Unknown',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.grey),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          price,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: SECONDARY_APP_COLOR),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )),
                        InkWell(
                          onTap: onRemovePress,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: SECONDARY_APP_COLOR,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text('Remove',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white)),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
