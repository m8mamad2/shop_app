import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class RowAnimationWidget extends StatelessWidget {
  MainAxisAlignment mainAxisAlignment;
  List<Widget> children;

  RowAnimationWidget(
      {super.key, required this.mainAxisAlignment, required this.children});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: AnimationConfiguration.toStaggeredList(
              childAnimationBuilder: (widget) => SlideAnimation(
                      child: FadeInAnimation(
                    child: widget,
                  )),
              children: children)),
    );
  }
}
