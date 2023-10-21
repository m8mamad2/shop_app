//     );

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/main_screens/presentation/screen/search_screen.dart';

import '../../../../../config/theme/cubit_changer/theme_cubit.dart';
import '../../../../../config/theme/theme.dart';
import '../../../../../core/animation/staggred_animation/row_animation.dart';

Widget homeSearchBarWidget(BuildContext context, ThemeCubit themeCubit) =>
    RowAnimationWidget(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
        onTap:()=>context.navigation(context, SearchScreen(inBottonNavbar: false)),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: sizeW(context) * 0.75,
          height: sizeH(context) * 0.058,
          decoration: BoxDecoration(
              color: BlocProvider.of<ThemeCubit>(context).isDark ?  theme(context).canvasColor : theme(context).backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow:const [
                BoxShadow(
                    blurRadius: 6,
                    offset:  Offset(3, 4),
                    color: Colors.black12)
              ]),
          child: Row(
            children: [
              Padding(
                padding:  EdgeInsets.all(sizeW(context)*0.03),
                child: Icon(
                  Icons.search,
                  color: theme(context).focusColor,
                  size: 22,
                ),
              ),
              Text('Search'.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(color: Colors.grey,fontSize: 17),)
            ],
          ),
        ),
      ),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: sizeW(context) * 0.12,
          height: sizeH(context) * 0.058,
          decoration: BoxDecoration(
              color: theme(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow:const [
                BoxShadow(
                  blurRadius: 6,
                  offset:  Offset(3, 4),
                  color: Colors.black12)
              ]),
          child: Icon(
            Icons.settings_outlined,
            size: 22,
            color:BlocProvider.of<ThemeCubit>(context).isDark ?  theme(context).focusColor : theme(context).canvasColor ,
          ))
    ]);
