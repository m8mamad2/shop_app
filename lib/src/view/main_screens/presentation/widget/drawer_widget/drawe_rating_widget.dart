// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/lottie.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';

import '../../../../../config/theme/cubit_changer/theme_cubit.dart';
import '../../../../../core/common/constans/size.dart';


class DrawerRatingWidget extends StatefulWidget {
  @override
  _DrawerRatingWidgetState createState() => _DrawerRatingWidgetState();
}
class _DrawerRatingWidgetState extends State<DrawerRatingWidget> {
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = 3;
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context,listen: false);
    return AlertDialog(
          backgroundColor:theme(context).dialogBackgroundColor,
          actions: [ 
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Please Rate Us'.tr(),style: theme(context).textTheme.displayMedium!.copyWith(color: theme(context).focusColor,fontSize: 22),),
                  ),
                  Stack(children: [
                  SizedBox(
                    height: sizeH(context)*0.238,
                    width: sizeW(context)*0.56,
                    child: kRatingLottie),
                  
                  _ratingBar(),
                    ]),
                  sizeBoxH(sizeH(context)*0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize:  Size(sizeW(context)*0.5,sizeH(context)*0.05),
                      backgroundColor: theme(context).primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    onPressed: ()=> context.navigationBack(context), child:Text('submit'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(fontFamily: 'arabic',color: theme(context).backgroundColor),))
                ],
              ),
            ),
        ]
    );
  }


  Widget _ratingBar() => Container(
    margin: EdgeInsets.only(top: sizeH(context) * 0.167),
    child: RatingBar.builder(
            glowColor: Theme.of(context).primaryColor,
            unratedColor: Theme.of(context).primaryColorDark.withAlpha(50),
            initialRating: 3,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return const Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                  );
                case 1:
                  return const Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                  );
                case 2:
                  return const Icon(
                    Icons.sentiment_neutral,
                    color: Colors.amber,
                  );
                case 3:
                  return const Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.lightGreen,
                  );
                case 4:
                  return const Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                  );
                default:
                  return Container();
              }
            },
            onRatingUpdate: (rating) {
              setState(() {
                rating = rating;
              });
            },
            updateOnDrag: true,
          ),
  );
  }
 


  