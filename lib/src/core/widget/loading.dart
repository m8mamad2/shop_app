import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';

Widget loading(BuildContext context) => Center(
      child: LoadingAnimationWidget.fourRotatingDots(
          color: theme(context).primaryColor, size: sizeW(context)*0.09),
    );



class LoadingDialogs extends StatelessWidget {
  const LoadingDialogs({super.key});


  static void show(BuildContext context) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogs(),);
      // ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));
  
  static void hide(BuildContext context) {
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            color: Colors.transparent,
            width: 100,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: LoadingAnimationWidget.inkDrop(
                  color: theme(context).primaryColor, size: 40),
            ),
          ),
        ),
      ),
    );
  }
}

