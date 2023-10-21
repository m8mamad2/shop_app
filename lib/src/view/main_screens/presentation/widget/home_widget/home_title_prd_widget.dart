import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/config/theme/theme.dart';

Widget homeTitleOfCollectionWidget(BuildContext context, String title) => Text(
      title.tr(),
      style: theme(context)
          .textTheme
          .headlineLarge!
          .copyWith(color: theme(context).focusColor, fontSize: 20),
    );
