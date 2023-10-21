import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/animation/staggred_animation/list_view_animation.dart';
import 'package:project3/src/core/common/constans/images.dart';
import 'package:project3/src/core/common/constans/size.dart';

 Widget homeSliderImgae(BuildContext context)=> Padding(
   padding:  EdgeInsets.symmetric(vertical: sizeH(context)*0.03),
   child: AnimationLimiter(
        child: CarouselSlider.builder(
          itemCount: 3, 
          options: CarouselOptions(
            height: sizeH(context)*0.21,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            autoPlay: true,
            reverse: true,
            // enlargeCenterPage: true
          ),
          itemBuilder: (context, index, realIndex) => ListViewAnimatinoWidget(
            index: index,
            child: oneItemImageSlider(context,isEnglish(context)? kEHorizonalmages[index] : kPHorizonalmages[index]), 
            ), 
          ),
      ),
 );

Widget oneItemImageSlider(BuildContext context,String name){
  bool isDark = BlocProvider.of<ThemeCubit>(context).isDark;
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    width: sizeW(context)*0.9,
    decoration: BoxDecoration(
        color: isDark ? theme(context).backgroundColor : theme(context).focusColor,
        borderRadius: BorderRadius.circular(20),
    ),

    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(name,width: sizeW(context),fit: BoxFit.cover,)),
        // Align(
        //   alignment: Alignment.bottomRight,
        //   child: Container(
        //     width: sizeW(context)*0.3,
        //     height: sizeH(context)*0.04, 
        //     color: theme(context).canvasColor,child: Text('')))
      ],
    ),
    
  );
}