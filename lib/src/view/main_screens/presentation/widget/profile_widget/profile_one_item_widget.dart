
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/theme.dart';

import '../../../../../core/common/constans/size.dart';

class ProfileOneItemWidet extends StatelessWidget {
  const ProfileOneItemWidet({
    super.key,
    required this.context,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final BuildContext context;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 6,
        color: theme(context).canvasColor,
        margin: EdgeInsets.symmetric(horizontal: sizeW(context) * 0.075, vertical: 10),
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none),
        child: ListTile(
          title: Text(
            title.tr(),
            style:isEnglish(context) 
              ? theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).focusColor,fontSize: sizeW(context)*0.035) 
              : theme(context).textTheme.titleSmall!.copyWith(fontSize: sizeW(context)*0.035,fontWeight: FontWeight.bold,color: theme(context).focusColor) ,
          ),
          leading: Icon(
            icon,
            color: theme(context).primaryColor,
          ),
          onTap: onTap,
        ),
      );
}
