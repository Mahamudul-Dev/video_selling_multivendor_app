import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect.circuller(
      {super.key,
      required this.width,
      required this.height,
      this.shapeBorder = const CircleBorder()});
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerEffect.rectangular(
      {super.key,
      required this.width,
      required this.height,
      this.shapeBorder = const RoundedRectangleBorder()});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade300,
          child: Container(
            height: height,
            width: width,
            decoration: ShapeDecoration(
                shape: shapeBorder, color: Colors.grey.shade400),
          )),
    );
  }
}
