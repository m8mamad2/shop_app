import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/images.dart';
import 'package:project3/src/core/common/constans/lottie.dart';
import 'package:project3/src/core/common/constans/size.dart';

   

Widget inUIDialogs(BuildContext context, String text,String subText,bool isSuccess,VoidCallback onpress) => AlertDialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  backgroundColor:theme(context).backgroundColor,
  actions: [
    Center(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: isSuccess ?  sizeW(context) * 0.4 : sizeW(context) * 0.21,
            height:isSuccess ?  sizeH(context) * 0.2 : sizeH(context) * 0.1,
            child: Image.asset(
              isSuccess 
                ? kSuccessDialogImage
                : kErrorDialogImage ,
                fit: BoxFit.cover,
                ),
            
            // child: LottieBuilder.asset(
            //   isSuccess ?  'assets/lottie/success.json' : 'assets/lottie/fail.json' ,
            //   fit: BoxFit.contain,
              
            //   )
          ),
        ),
        Padding(
          padding:  EdgeInsets.all(sizeW(context)*0.01),
          child: Column(
            children: [
              Text(
                text.tr(),
                textAlign: TextAlign.center,
                style: theme(context).textTheme.headlineLarge!.copyWith(color: isSuccess ? const Color(0xff3f8efc) : const Color(0xffec0000),fontWeight: FontWeight.w600,fontSize: sizeW(context)*0.044),
              ),
              sizeBoxH(5),
              Text(
                subText.tr(),
                textAlign: TextAlign.center,
                style: theme(context).textTheme.titleSmall!.copyWith(
                  color: theme(context).focusColor.withOpacity(0.8),fontSize: sizeW(context)*0.03),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: sizeH(context)*0.02,top: sizeH(context)*0.05),
          child: ElevatedButton(
          onPressed: onpress, 
          style: ElevatedButton.styleFrom(
            backgroundColor: isSuccess ? const Color(0xff3f8efc) : const Color(0xffec0000),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            minimumSize: Size(sizeW(context)*0.43, sizeH(context)*0.046)
          ),
          child: Text('ok'.tr()),
          ),
        )
      ],),
    ),]
);
