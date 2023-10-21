import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/core/common/constans/lottie.dart';
import 'package:project3/src/core/common/constans/texts.dart';
import 'package:project3/src/view/onboadfing_screens/widget/onboarding_appBar_widget.dart';
import 'package:project3/src/view/onboadfing_screens/widget/onboarding_body_widget.dart';
import 'package:project3/src/view/onboadfing_screens/widget/onboarding_bottom_widget.dart';

import '../../../config/localization/is_english.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  PageController controller = PageController(initialPage: 0);
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: onboardingAppBarWidget(controller, isLastPage,context,onPress),
        body: PageView.builder(
          onPageChanged: (value) => setState(() => isLastPage = value == 2),
          itemCount: 3,

          controller: controller,
          itemBuilder: (context, index) => OnBoardingBodyWidget(
            title: onboardingTitles[index],
            subTitle: onboardingsubTitles[index],
            lottie: onboardingListLottie[index],
          ),
        ),
        bottomNavigationBar: OnBoardingBottomNavbar(controller: controller, isLastPage: isLastPage));
  }

  onPress()async{
    isEnglish(context) 
            ? context.setLocale(const Locale('fa','IR'))
            : context.setLocale(const Locale('en','US'));
    setState(() {});
  }
}
