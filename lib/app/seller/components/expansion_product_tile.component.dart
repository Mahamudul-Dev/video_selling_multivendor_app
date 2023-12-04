import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_selling_multivendor_app/themes/app_colors.dart';

class ExpansionProductTile extends StatelessWidget {
  const ExpansionProductTile({
    Key? key,
    required this.productName,
    required this.productThumbnail,
    required this.duration,
    required this.totalClicks,
    required this.totalSaleTime,
    required this.totalEarning,
    required this.category,
  }) : super(key: key);

  final String productName;
  final String productThumbnail;
  final String duration;
  final String totalClicks;
  final String totalSaleTime;
  final String totalEarning;
  final String category;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: CachedNetworkImage(
        imageUrl: productThumbnail,
        fit: BoxFit.fitWidth,
        width: 80,
        height: 60,
      ),
      title: Text(
        productName,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: Colors.white),
      ),
      subtitle: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.ads_click_rounded,
                color: Colors.grey.shade300,
                size: 10,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Total Clicks: $totalClicks',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey.shade300, fontSize: 8),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.watch_later_outlined,
                color: Colors.grey.shade300,
                size: 10,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(duration,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey.shade300, fontSize: 8),
                  overflow: TextOverflow.ellipsis)
            ],
          )
        ],
      ),
      childrenPadding: const EdgeInsets.all(15.0),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Sale Time',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey.shade300),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  totalSaleTime,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey.shade300),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Earnings',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey.shade300),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$ $totalEarning',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey.shade300),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey.shade300),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  category,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey.shade300),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 30,
                child: ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    child: Text(
                      'See Details',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: SECONDARY_APP_COLOR),
                    )))
          ],
        )
      ],
    );
  }
}
