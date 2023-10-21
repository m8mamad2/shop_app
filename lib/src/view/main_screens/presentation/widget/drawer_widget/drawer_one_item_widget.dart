
  import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';

import '../../../../../config/theme/theme.dart';
import '../../../../../core/common/constans/size.dart';

Widget drawerOneItmeWidget(BuildContext context, IconData icon, String title,dynamic widget, int index) =>
    InkWell(
      onTap: () => index == 6
          ? showDialog(
              context: context,
              builder: (context) => widget,
            )
          : context.navigation(context, widget),
      child: SizedBox(
        height: sizeH(context) * 0.075,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeW(context)*0.05),
          child: Row(
            children: [
              Icon(
                icon,
                size: sizeW(context)*0.07,
                color: theme(context).backgroundColor.withOpacity(0.5),
              ),
              sizeBoxW(sizeH(context)*0.02),
              Text(
                title.tr(),
                style: theme(context).textTheme.titleLarge!.copyWith(fontSize: sizeW(context)*0.037,color: theme(context).backgroundColor),
              ),
              const Spacer(),
              Icon(isEnglish(context) ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_new_rounded,size: sizeW(context)*0.05,color: theme(context).backgroundColor.withOpacity(0.4),)
            ],
          ),
        ),
      ),
    );
