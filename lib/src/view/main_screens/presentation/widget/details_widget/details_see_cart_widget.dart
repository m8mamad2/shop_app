import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/view/main_screens/presentation/screen/cart_screen.dart';

Widget detailsSeeCartWidget(BuildContext context, Color color) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Added'.tr(),
            style: theme(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 13,color: theme(context).focusColor),
          ),
          InkWell(
              // onTap: () => context.beamToNamed('/cart',data:false),//context.go('/cart',extra: false),
              // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen(isBottomNavbar: false),)),//context.go('/cart',extra: false),
              onTap: () => context.navigation(context, const BottomNavigateWidget(selected: 2,)),//context.go('/cart',extra: false),
              child: Text.rich(TextSpan(children: [
            TextSpan(
                text: 'view '.tr(),
                style: theme(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 16,color: theme(context).focusColor)),
            TextSpan(
                text: 'shopping Cart'.tr(),
                style: theme(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 19, color: color)),
          ])))
        ],
      ),
    );
