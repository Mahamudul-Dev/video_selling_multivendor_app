import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
          color: color ?? Theme.of(context).colorScheme.onBackground, size: 30),
    );
  }
}
