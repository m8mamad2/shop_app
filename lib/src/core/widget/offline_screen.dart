
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/lottie.dart';
import 'package:project3/src/core/common/constans/size.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key});

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff333040),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sizeBoxH(sizeH(context)*0.12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeW(context)*0.1),
              child: Text('no internet connection found.check your connection or try again'.tr(),
                textAlign: TextAlign.center,
                style: theme(context).textTheme.headlineLarge!.copyWith(
                  fontSize: sizeW(context)*0.04,
                  color: Colors.white),),
            ),
            SizedBox(
              height: sizeH(context)*0.5,
              width: sizeW(context)*0.85,
              child: kLostConnectionLottie,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sizeW(context)*0.1),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(sizeW(context)*0.8, sizeH(context)*0.065),
                      backgroundColor: Colors.white38
                    ),
                    onPressed: (){setState(() {});}, 
                    child: Text('ok'.tr())),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}