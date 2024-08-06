import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/widget/badge.dart';
import '../../../../../config/theme/theme.dart';

SliverAppBar homeAppbar(BuildContext context) => SliverAppBar(
        toolbarHeight: sizeH(context) * 0.08,
        backgroundColor:BlocProvider.of<ThemeCubit>(context).isDark ?  theme(context).backgroundColor : theme(context).canvasColor ,
        leading: Builder(
            builder: (c) => Padding(
                  padding:EdgeInsets.symmetric(horizontal: sizeW(context) * 0.03),
                  child: Builder(
                    builder:(context) {
                      return IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: theme(context).focusColor,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer());}
                  ),
                )),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW(context) * 0.04,vertical: sizeH(context)*0.01),
            child: BadgeWidget(color: theme(context).focusColor),
          )
        ]);


