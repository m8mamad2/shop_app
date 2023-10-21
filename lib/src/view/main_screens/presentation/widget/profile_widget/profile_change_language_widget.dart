import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/images.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/main_screens/presentation/widget/profile_widget/profile_hexagon_language_widget.dart';

import '../../../../../core/common/constans/size.dart';

class ProfileChangeLanguageWidget extends StatefulWidget {
  const ProfileChangeLanguageWidget({super.key});

  @override
  State<ProfileChangeLanguageWidget> createState() => _ProfileChangeLanguageWidgetState();
}

class _ProfileChangeLanguageWidgetState extends State<ProfileChangeLanguageWidget> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: theme(context).backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sizeBoxH(sizeH(context) * 0.01,),
            Text(
              'Select a Language'.tr(),
              style: theme(context).textTheme.displayMedium!.copyWith(color: theme(context).primaryColor,fontSize: 20)
            ),
            sizeBoxH(sizeH(context) * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                oneItam(kIranLanguageImage, 'ایران', context, 'fa', 'IR'),
                oneItam(kUSLanguageImage, 'English', context, 'en', 'US'),
              ],
            ),
            sizeBoxH(sizeH(context) * 0.02),
          ],
        ),
      ],
    );
  }
    Widget oneItam(String flag, String title, BuildContext context, String languageCode, String counrtyCode) =>
      InkWell(
        onTap: () {
          context.setLocale(Locale(languageCode, counrtyCode));
          setState((){});
        },
        child: Column(children: [
          ClipPath(
            clipper: HexagonClipper(),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(flag,),
                    fit: BoxFit.cover),
              ),
              width: 76,
              height: 80,
            ),
          ),
          sizeBoxH(10),
          Text(
            title,
            style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor),
          )
        ]),
      );

}
