
//import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/animation/staggred_animation/list_view_animation.dart';
import 'package:project3/src/core/common/constans/icons.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/constans/texts.dart';
import 'package:project3/src/core/common/router.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/main_screens/presentation/screen/category_list_products_screen.dart';

import '../../../../../config/theme/cubit_changer/theme_cubit.dart';
import '../../../../../core/common/constans/images.dart';

Widget homeCategoryWidget(BuildContext context){
  ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context,listen: false);
  return Container(
      color:themeCubit.isDark ? theme(context).backgroundColor: theme(context).canvasColor,
      margin: EdgeInsets.only(top: sizeH(context)*0.023),
      height: sizeH(context) * 0.1,
      width: double.infinity,
      child: AnimationLimiter(
              child: Padding(
                padding:isEnglish(context)? EdgeInsets.only(left: sizeW(context)*0.03):EdgeInsets.only(right: sizeW(context)*0.03),
                child: ListView.builder(
                    itemCount: kCategoryText.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) => ListViewAnimatinoWidget(
                      index: index,
                      child: buuu(
                            context,
                            index,
                            themeCubit.isDark ? kHomeDarkCategoryIcons[index] : kHomeLightCategoryIcons[index],
                            kHomeCategoryTitle[index],
                            kCategoryText[index]),
                      
                    )),
              ),
            ));
          }

//! one of the your circular avatar
Widget buuu(BuildContext context, int index,Widget icon, String text,String title) {
  return InkWell(
    onTap: (){
      CategoryListOfPrdRouter data = CategoryListOfPrdRouter(
        title: title, 
        image: kHomeCategoryImages[index], 
        endPoint: kHomeCategoryEndPoints[index]);
        context.navigation(context, CategoryListProductsScreen(data: data));
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryListProductsScreen(data: data),));
      // context.beamToNamed('/listOfPrd', data:data);
    },
    child: 
    Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),

        // child: CircleAvatar(
        //   radius: sizeW(context)*0.07,
        //   backgroundColor: theme(context).backgroundColor,
        //   child: icon,
        // ),

        // child: Container(
        //   width: sizeW(context)*0.25,
        //   height: sizeH(context)*0.05,
        //   decoration: BoxDecoration(
        //     border: Border.all(color: theme(context).focusColor,width: 0.1),
        //     borderRadius: BorderRadius.circular(15),
        //     color:theme(context).backgroundColor,
        //     // boxShadow: const [
        //     //   BoxShadow(
        //     //       blurRadius: 4,
        //     //       offset:  Offset(3, 3),
        //     //       color: Colors.black12)]
          
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       icon,
        //       sizeBoxW(2),
        //       Text(title.tr(),style:isEnglish(context) 
        //         ? theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).focusColor,fontSize: sizeW(context)*0.035) 
        //         : theme(context).textTheme.titleSmall!.copyWith(fontSize: 13,color: theme(context).focusColor))
        //     ],
        //   ),
        // )

          child:Column(children: [
          Container(
            decoration: BoxDecoration(
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 6,
                          offset:  Offset(1, 1),
                          color: Colors.black12)
                    ]
                      ),
            child: CircleAvatar(
              radius: 27,
              backgroundColor:BlocProvider.of<ThemeCubit>(context).isDark ?theme(context).canvasColor : theme(context).backgroundColor,
              child: icon,
            ),
          ),
          sizeBoxH(sizeH(context)*0.007),
          Text(
            text.tr(),
            style: theme(context).textTheme.titleSmall!.copyWith(fontSize: 12,color: theme(context).focusColor),
          )
        ]),

      ),
    ),
  );
}
