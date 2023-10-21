import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/images.dart';
import 'package:project3/src/core/common/constans/lottie.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/constans/texts.dart';

class ErrorBlocWidget extends StatefulWidget {
  const ErrorBlocWidget({super.key});

  @override
  State<ErrorBlocWidget> createState() => _ErrorBlocWidgetState();
}

class _ErrorBlocWidgetState extends State<ErrorBlocWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDark = BlocProvider.of<ThemeCubit>(context).isDark;
    return Scaffold(
      backgroundColor: theme(context).backgroundColor,
      appBar: AppBar( 
        backgroundColor: theme(context).backgroundColor,
        elevation: 0,
        actions: null,
        leading: null),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBoxH(sizeH(context)*0.1),
          SizedBox(
            width: sizeW(context)*0.9,
            child: isDark ? kErrorBLocDarkLottie : kErrorBLocLightLottie,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW(context)*0.05,vertical: sizeH(context)*0.02),
            child: Text('there is a problem. Some of the reasons and solutions are:'.tr(),
              style: theme(context).textTheme.titleSmall!
              .copyWith(
                color: theme(context).focusColor,
                fontWeight: FontWeight.w800,
                fontSize: sizeW(context)*0.044
            ),),
          ),
          sizeBoxH(sizeH(context)*0.04),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) => oneItem(kErrorBloc[index]),)
        ],
      ),
    );
  }
  Widget oneItem(String text)=> Padding(
    padding: EdgeInsets.symmetric(horizontal: sizeW(context)*0.05,vertical: sizeH(context)*0.01),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: theme(context).focusColor,
          radius: sizeW(context)*0.01,),
        sizeBoxW(sizeW(context)*0.01),
        Text(text.tr(),
          style: theme(context).textTheme.titleSmall!.copyWith(
            fontSize: sizeW(context)*0.035,
            color: theme(context).focusColor.withOpacity(0.5)
          ),)
      ],
    ),
  );
}