import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

final LottieBuilder onboardignLottie1 =Lottie.asset('assets/lottie/onboarding1.json');
final LottieBuilder onboardignLottie2 =Lottie.asset('assets/lottie/onboarding2.json');
final LottieBuilder onboardignLottie3 =Lottie.asset('assets/lottie/onboarding3.json');

final List<LottieBuilder> onboardingListLottie = [
  onboardignLottie1,
  onboardignLottie2,
  onboardignLottie3
];

final LottieBuilder kAuthErrorLottie =LottieBuilder.asset('assets/lottie/auth_error.json',fit: BoxFit.contain);

// final LottieBuilder kSuccessLottie = 
// LottieBuilder.asset('assets/lottie/success.json',fit: BoxFit.contain,);
// final LottieBuilder kFailLottie = 
// LottieBuilder.asset('assets/lottie/fail.json',fit: BoxFit.contain);

final LottieBuilder kRatingLottie = LottieBuilder.asset('assets/lottie/rating.json');

final LottieBuilder kDarkEmptyLottie = LottieBuilder.asset('assets/lottie/empty_dark.json');
final LottieBuilder kLightEmptyLottie = LottieBuilder.asset('assets/lottie/empty_light.json');

final LottieBuilder kDarkSearchLottie = LottieBuilder.asset('assets/lottie/search_dark.json');
final LottieBuilder kLightSearchLottie = LottieBuilder.asset('assets/lottie/search_light.json');

final LottieBuilder kReportErrorLottie = LottieBuilder.asset('assets/lottie/report_error.json');

final LottieBuilder kLostConnectionLottie = LottieBuilder.asset('assets/lottie/lost_connection.json');

final LottieBuilder kWalkingLottie = LottieBuilder.asset('assets/lottie/walking.json');

final LottieBuilder kSuccessPaymentLottie = LottieBuilder.asset('assets/lottie/success_payment.json',fit: BoxFit.cover,);

final LottieBuilder kErrorBLocLightLottie = LottieBuilder.asset('assets/lottie/error_bloc_light.json') ;
final LottieBuilder kErrorBLocDarkLottie = LottieBuilder.asset('assets/lottie/error_bloc_dark.json') ;