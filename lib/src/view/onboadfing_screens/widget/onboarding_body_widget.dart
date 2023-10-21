import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';

class OnBoardingBodyWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final LottieBuilder lottie;
  const OnBoardingBodyWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.lottie,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(width: sizeW(context), child: lottie),
        ),
        Expanded(
          child: Text(
            title.tr(),
            style: theme(context).textTheme.displayMedium!.copyWith(color: theme(context).focusColor,fontSize: sizeW(context)*0.07,fontWeight: FontWeight.w300),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW(context) * 0.08),
            child: Text(
              subTitle.tr(),
              style: theme(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
