import 'package:flutter/material.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';

class CheckoutSegmentTitleWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const CheckoutSegmentTitleWidget(Key? key, this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top: 25, bottom: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Text(
              title,
              style:theme(context).textTheme.headlineLarge!.copyWith(fontSize: 18,color: theme(context).focusColor),
            ),
            Icon(icon,color: theme(context).focusColor,),
           sizeBoxW(sizeH(context)*0.01)
          ],
        ),
      ),
    );
  }
}
