import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';


class CheckoutContinueButton extends StatelessWidget {
  final num total;
  final VoidCallback onpress;
  final double marginFromTop;
  const CheckoutContinueButton({super.key,required this.total,required this.onpress,required this.marginFromTop});

  @override
  Widget build(BuildContext context) {
    bool isDark = BlocProvider.of<ThemeCubit>(context).isDark;
    return Container(
      margin: EdgeInsets.only(top: marginFromTop),
      padding:const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
          color: theme(context).primaryColor,
          borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      height: sizeH(context) * 0.155,
      width: sizeW(context) * 0.9,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Payment'.tr(),
                  style: theme(context).textTheme.titleMedium!.copyWith(
                      color:isDark ? theme(context).focusColor : theme(context).backgroundColor, fontSize: 15),
                ),
                // Text('\$$finalTotal',
                Text('\$ $total',
                    style: theme(context).textTheme.titleMedium!.copyWith(
                        color: isDark ? theme(context).focusColor:theme(context).canvasColor, fontSize: 17)),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize:Size(sizeW(context) * 0.75, sizeH(context) * 0.05),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: theme(context).canvasColor,
            ),
            onPressed: onpress,
            child: Text(
              'continue'.tr(),
              style: theme(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14, color: theme(context).focusColor),
            ),
          ),
        ],
      ),
    );
  }
}
