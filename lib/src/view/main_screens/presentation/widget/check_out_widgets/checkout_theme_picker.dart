import 'package:flutter/material.dart';
import 'package:project3/src/config/theme/theme.dart';

class CheckoutPickerTheme extends StatelessWidget {
  final Widget? child;
  final bool isDark;
  const CheckoutPickerTheme({super.key,this.child,required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: 
        isDark 
          ?theme(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: theme(context).primaryColor,
              onSurface: theme(context).focusColor,
              
              ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
              backgroundColor: theme(context).backgroundColor,
              textStyle: theme(context).textTheme.titleSmall!,

                ))
          )
          :theme(context).copyWith(
            colorScheme: ColorScheme.light(
              background: theme(context).backgroundColor,
              primary: theme(context).primaryColor,
              onPrimary: theme(context).backgroundColor,
              onSurface: theme(context).focusColor),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
              foregroundColor: theme(context).focusColor,
                ))
          ),
      child: child!,
    );
  }
}