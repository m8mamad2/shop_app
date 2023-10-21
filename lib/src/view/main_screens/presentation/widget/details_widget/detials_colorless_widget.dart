import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/icons.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';

import '../../../../../config/localization/is_english.dart';
import '../../../../../core/common/constans/size.dart';
import '../../../domain/entities/products_entity.dart';
import '../../screen/home_screen.dart';

// ignore: non_constant_identifier_names
Container DetailsColorLessWidget(BuildContext context, ProductsEntity? prd, Color prdColor) {
  return Container(
    color: theme(context).canvasColor,
    width: sizeW(context) * 0.48,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      IconButton(
          onPressed: () =>context.navigationBack(context),
          icon: kArrowIcon(context, theme(context).focusColor),),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: sizeH(context) * 0.09,
              width: sizeW(context) * 0.4,
              child: FittedBox(
                child: Text(prd!.title!,style: theme(context).textTheme.titleLarge!.copyWith(color: theme(context).focusColor)),
              ),
            ),
            Container(
              width: sizeW(context) * 0.16,
              height: sizeH(context) * 0.035,
              decoration: BoxDecoration(color: prdColor, borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 15,
                    color: theme(context).backgroundColor,
                  ),
                  Text(
                    ' 4.2',
                    style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).backgroundColor),
                  )
                ],
              ),
            ),
            sizeBoxH(sizeH(context) * 0.18),
            Text(
              ' price '.tr(),
              style: theme(context).textTheme.titleSmall!.copyWith(
                  color: theme(context).focusColor,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            Text.rich(
              TextSpan(children: [
                const TextSpan(text: '\$ ',),
                TextSpan(text: '${prd.price}'),
              ]),
              style: theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).focusColor,fontSize: sizeW(context)*0.1),
            )
          ],
        ),
      ),
    ]),
  );
}
