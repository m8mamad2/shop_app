import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/config/localization/is_english.dart';

PreferredSizeWidget onboardingAppBarWidget(
  PageController controller,
  bool isLastPage,
  BuildContext context,
  VoidCallback onPress
) =>
    AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.language_outlined),
        onPressed: onPress
      ),
      actions: [IconButton(
        icon: isLastPage
            ? Container()
            : isEnglish(context) ?const Icon(Icons.arrow_forward):const Icon(Icons.arrow_forward),
        onPressed: () => controller.jumpToPage(2),
      ),],
      elevation: 0,
    );
