// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project3/src/core/common/constans/colors.dart';

ThemeData theme(BuildContext context) => Theme.of(context);

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(

      //!
      backgroundColor: kLightBackgroundColor,
      canvasColor: kLightSecondBGColor,

      focusColor: kLightBlackColor,
      dialogBackgroundColor: kLightBackgroundImage,
      
      primaryColor: kLightDarkBlueColor,
      accentColor: kLightPaleBlueColor,
      //!
      appBarTheme: lightAppBarTheme,
      textTheme: lightTextTheme);

  static final ThemeData darkTheme = ThemeData(

    backgroundColor: kDarkBackgroundColor,
    canvasColor: kDarkSecondBGColor,

    focusColor: kDarkWhiteColor,
    dialogBackgroundColor: kDarkBackgroundImage,

    primaryColor: kLightDarkBlueColor,
    accentColor: kLightPaleBlueColor,

    appBarTheme: darkAppBarTheme,
    textTheme: darkTextTheme
  );

  static const AppBarTheme lightAppBarTheme = AppBarTheme(iconTheme: IconThemeData(color: kLightDarkBlueColor));
  static final AppBarTheme darkAppBarTheme = AppBarTheme();

  static const TextTheme lightTextTheme =  TextTheme(
    displayMedium: TextStyle(fontFamily: 'header'),
    headlineLarge: TextStyle(fontFamily: 'header'),
    titleSmall: TextStyle(fontFamily: 'body'),
    bodyLarge: TextStyle(fontFamily: 'body'),
    bodySmall: TextStyle(fontFamily: 'body'),
  );
  static const TextTheme darkTextTheme = TextTheme(
    displayMedium: TextStyle(fontFamily: 'header'),
    headlineLarge: TextStyle(fontFamily: 'header'),
    titleSmall: TextStyle(fontFamily: 'body'),
    bodyLarge: TextStyle(fontFamily: 'body'),
    bodySmall: TextStyle(fontFamily: 'body'),

  );
}
