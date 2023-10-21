import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/main_screens/presentation/widget/check_out_widgets/checkout_change_card.dart';

import '../../../../../config/localization/is_english.dart';

class CheckoutEmptyCard extends StatelessWidget {
  final num total;
  const CheckoutEmptyCard({super.key,required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW(context) * 0.85,
      height: sizeH(context) * 0.24,
      decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            theme(context).primaryColor.withOpacity(0.7),
            theme(context).primaryColor,
            theme(context).primaryColor,
          ], radius: 1.3, center: const Alignment(0.5, -0.5)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                color: BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).backgroundColor : theme(context).focusColor.withOpacity(0.5),
                offset: const Offset(0, 7))
          ]),
      child: Column(children: [
        sizeBoxH(8.27),
        Text(
          'Please Add a Card'.tr(),
          style: theme(context)
              .textTheme
              .displayMedium!
              .copyWith(color: theme(context).backgroundColor,fontSize: 18),
        ), 

        Container(
          margin: EdgeInsets.only(
            left: sizeW(context)*0.7,
            top: sizeH(context)*0.13),
          decoration: BoxDecoration(
              color: theme(context).backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          width: sizeH(context) * 0.06,
          height: sizeH(context) * 0.05,
          child: IconButton(
              onPressed: () =>  context.navigation(context,CheckoutChangeCard(total: total,)),
              icon: Icon(Icons.add,color: theme(context).focusColor,)),
        )
      ]),
    );
  }
}
