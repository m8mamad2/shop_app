import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/core/common/tasks/tasks.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/common/constans/size.dart';
import '../../main_screens/presentation/screen/home_screen.dart';

class OnBoardingBottomNavbar extends StatelessWidget {
  final PageController controller;
  final bool isLastPage;
  const OnBoardingBottomNavbar(
      {super.key, required this.controller, required this.isLastPage});

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: sizeH(context) * 0.1,
      child: Row(
        children: [
          SmoothPageIndicator(
              onDotClicked: (index) => controller.jumpToPage(index),
              controller: controller,
              count: 3,
              effect: JumpingDotEffect(
                  activeDotColor: Theme.of(context).primaryColor,
                  dotColor: theme.isDark ? Colors.white24 : Colors.black26,
                  dotWidth: 8,
                  dotHeight: 8,
                  spacing: 5,
                  verticalOffset: 10)),
          const Spacer(),
          isLastPage
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:Size(sizeW(context) * 0.35, sizeH(context) * 0.055),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Tasks.setFirstTime();
                    context.navigation(context, const BottomNavigateWidget());
                  },
                  child: Text(
                    'Let go!'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ))
              : ElevatedButton(
                  onPressed: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear),
                  style: ElevatedButton.styleFrom(
                    minimumSize:Size(sizeW(context) * 0.25, sizeH(context) * 0.05),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                  ),
                  child: Text(
                    'Next'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  )),
        ],
      ),
    );
  }
}
