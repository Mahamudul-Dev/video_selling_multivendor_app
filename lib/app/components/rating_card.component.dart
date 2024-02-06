import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({super.key, required this.authorName, required this.ratingPoint, required this.ratingMessage, required this.authorProfileImage});

  final String authorName;
  final double ratingPoint;
  final String ratingMessage;
  final String authorProfileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        children: [
          Expanded( flex: 2, child: Center(child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.outline,
            backgroundImage: CachedNetworkImageProvider(authorProfileImage),
          ),)),


          Expanded(flex: 5, child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(authorName, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground), overflow: TextOverflow.ellipsis,),

                  const SizedBox(height: 6,),
                  Text(ratingMessage,  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground), maxLines: 4, overflow: TextOverflow.ellipsis,),

                ],
              ),
              RatingBar.builder(
                  initialRating: ratingPoint,
                  unratedColor: Colors.grey,
                  allowHalfRating: true,
                  itemCount: 5,

                  itemSize: 15,
                  ignoreGestures: true,
                  itemPadding:
                  const EdgeInsets.symmetric(horizontal: 1.5),
                  itemBuilder: (context, index) {
                    return const Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  onRatingUpdate: (value) {})

            ],
          )),


          Expanded(flex: 1, child: Center(child: Text(ratingPoint.toString(), style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.yellow)),))
        ],
      )

      // ListTile(
      //   tileColor: Theme.of(context).colorScheme.secondaryContainer,
      //   isThreeLine: true,
      //   leading: CircleAvatar(
      //     backgroundColor: Theme.of(context).colorScheme.outline,
      //     backgroundImage: CachedNetworkImageProvider(authorProfileImage),
      //   ),
      //
      //   title: Text(authorName, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground), overflow: TextOverflow.ellipsis,),
      //
      //   subtitle: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Text(ratingMessage,  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground), maxLines: 4, overflow: TextOverflow.ellipsis,),
      //
      //       RatingBar.builder(
      //           initialRating: ratingPoint,
      //           unratedColor: Colors.grey,
      //           allowHalfRating: true,
      //           itemCount: 5,
      //
      //           itemSize: 15,
      //           ignoreGestures: true,
      //           itemPadding:
      //           const EdgeInsets.symmetric(horizontal: 1.5),
      //           itemBuilder: (context, index) {
      //             return const Icon(
      //               Icons.star,
      //               color: Colors.amber,
      //             );
      //           },
      //           onRatingUpdate: (value) {})
      //
      //     ],
      //   ),
      //
      //   trailing: Text(ratingPoint.toString(), style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.yellow)),
      // ),
    );
  }
}
