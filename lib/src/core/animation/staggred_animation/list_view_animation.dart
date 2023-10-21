import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListViewAnimatinoWidget extends StatelessWidget {
  Widget child;
  int index;
  ListViewAnimatinoWidget(
      {super.key, required this.child, required this.index});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 1000),
      child: SlideAnimation(
        verticalOffset: 10,
        child: FadeInAnimation(child: child),
      ),
    );
  }
}
