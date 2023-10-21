import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';

import '../../../../../config/theme/theme.dart';
import '../../../../../core/common/constans/icons.dart';
import '../../../../../core/common/constans/size.dart';

PreferredSizeWidget chatAppBarWidget(BuildContext context)=> AppBar(
            backgroundColor:BlocProvider.of<ThemeCubit>(context).isDark ?theme(context).backgroundColor : theme(context).canvasColor,
            toolbarHeight: sizeH(context) * 0.095,
            leadingWidth: sizeW(context) * 0.15,
            titleSpacing: 0,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.navigationBack(context),
              icon: kArrowIcon(context, theme(context).primaryColor),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: theme(context).dialogBackgroundColor,
                    child:  Icon(
                      Icons.person,
                      color: theme(context).focusColor,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    margin: const EdgeInsets.all(6),
                    child: Text('Support'.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: sizeW(context)*0.04,color: theme(context).focusColor),
                      )
                  ),
                ],
              ),
            ),
          );
