import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    required this.onDetailsPressed
  }) : super(key: key);

  final String productName;
  final String productThumbnail;
  final String duration;
  final String totalClicks;
  final String totalSaleTime;
  final String totalEarning;
  final String category;
  final void Function()? onDetailsPressed;

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
            .labelMedium,
      ),
      subtitle: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.ads_click_rounded,
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
                    ?.copyWith(fontSize: 8),
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
              const Icon(
                Icons.watch_later_outlined,
                size: 10,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(duration,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 8),
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
                      .bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  totalSaleTime,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall,
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
                      .bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$ $totalEarning',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall,
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
                      .bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  category,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall,
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
                    onPressed: onDetailsPressed,
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    child: Text(
                      'See Details',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    )))
          ],
        )
      ],
    );
  }
}
