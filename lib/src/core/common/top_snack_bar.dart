import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../config/theme/theme.dart';

showSnackBarOnTop(BuildContext context, String title) {
  showTopSnackBar(
      Overlay.of(context)!,
      // isWrite ?
      CustomSnackBar.info(
          icon: const SizedBox.shrink(),
          backgroundColor: theme(context).dialogBackgroundColor,
          textStyle: theme(context)
              .textTheme
              .titleMedium!
              .copyWith(color: theme(context).focusColor, fontSize: 16),
          message: title)
      // : CustomSnackBar.error(
      //   textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).primaryColor,fontSize: 16),
      //   backgroundColor: Theme.of(context).primaryColorLight,
      //   message: title)

      );
}
