// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ColumnAnimatinoWidget extends StatelessWidget {
  MainAxisAlignment mainAxisAlignment;
  List<Widget> children;
  ColumnAnimatinoWidget(
      {super.key, required this.children, required this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) => AnimationLimiter(
          child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 1000),
            childAnimationBuilder: (widget) => SlideAnimation(
                    child: FadeInAnimation(
                  child: widget,
                )),
            children: children),
      ));
}
