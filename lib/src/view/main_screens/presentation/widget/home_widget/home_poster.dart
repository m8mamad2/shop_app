import 'package:flutter/material.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/core/animation/staggred_animation/row_animation.dart';
import 'package:project3/src/core/common/constans/images.dart';
import 'package:project3/src/core/common/constans/size.dart';

Widget poster(String image, double width, double height) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          // boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black)]
          ),
      width: width, //163,
      height: height, //290,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(image,fit: BoxFit.cover,),
      ),
    );

Widget homePostersWidget(BuildContext context,) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeW(context)*0.06,vertical: sizeH(context)*0.03),
      child: RowAnimationWidget(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        poster(isEnglish(context) ? kEVertical1Image : kPVertical1Image, sizeW(context)*0.4, sizeH(context)*0.4),
        poster(isEnglish(context) ? kEVertical2Image : kPVertical2Image, sizeW(context)*0.4, sizeH(context)*0.4),
      ]),
    );
