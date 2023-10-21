import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project3/src/core/animation/staggred_animation/list_view_animation.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/details_router_object.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/cached_image.dart';
import 'package:project3/src/view/main_screens/presentation/screen/details_screen.dart';

import '../../../../../config/theme/cubit_changer/theme_cubit.dart';
import '../../../../../config/theme/theme.dart';
import '../../../domain/entities/products_entity.dart';

Widget homeCarsoureSliderWidget(BuildContext context, List<ProductsEntity>? entity) =>
    AnimationLimiter(
      child: SizedBox(
        height: sizeH(context) * 0.4,
        width: sizeW(context),
        child:CarouselSlider.builder(
      itemCount: 10,
      options: CarouselOptions(          
        height: sizeH(context) * 0.36,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIndex) {
        return ListViewAnimatinoWidget(
            index: index, child: oneSliderItem(entity, index, context));
      },
    ),
        // child: InfiniteCarousel.builder(

        //   itemExtent: sizeW(context)*0.6,
        //   itemCount: 10,
        //   physics: const InfiniteScrollPhysics(parent: ScrollPhysics()),
        //   controller: controller,
        //   axisDirection: Axis.horizontal,
        //   velocityFactor: 0.5,
        //   anchor: 1,
        //   center: true,
    
        //   itemBuilder: (context, index, realIndex) =>
        //      ListViewAnimatinoWidget(index: index, child: oneSliderItem(entity, index, context))
          
        // ),
      ),
    );

Widget oneSliderItem( List<ProductsEntity>? entity, int index, BuildContext context) {
  ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: false);
  return Container(
    color: theme(context).colorScheme.secondary.withOpacity(0.01),
    width: sizeW(context)*0.73,
    child: InkWell(
      onTap: ()  =>context.navigation(context, DetailsScreen(data: entity[index])),
      child: Stack(children: [
        // ? container background
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(bottom: 25),
            height: sizeW(context) * 0.62,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,end: Alignment.centerLeft,
                colors: [
                  theme(context).primaryColor.withOpacity(0.7),
                  theme(context).primaryColor,
                  theme(context).primaryColor,
                ]),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
       
        // ? image ,text
        Column(
          children: [
            //? image
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: theme(context).focusColor.withOpacity(0.3),width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    color:themeCubit.isDark ? theme(context).canvasColor : theme(context).backgroundColor,
                    ),
                alignment: Alignment.topCenter,
                height: sizeH(context) * 0.21,
                width: sizeW(context) * 0.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: cachedImageWidget(context, entity![index].image!,
                      sizeW(context) * 0.6, sizeH(context) * 0.22),
                ),
              ),
            ),
            //? text
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 15, left: 25),
                child: Text(entity[index].title!.toString(),
                    style: theme(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color:themeCubit.isDark ? theme(context).focusColor : theme(context).canvasColor,
                      fontSize: sizeH(context)*0.018,))),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 5, left: 25),
              child: Text(
                " ${entity[index].price!.toString()} \$",
                style: theme(context).textTheme.displayMedium!.copyWith(color: themeCubit.isDark ? theme(context).focusColor : theme(context).canvasColor,fontSize: sizeH(context)*0.02),
              ),
            ),
          ],
        ),
        //? button
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            // onTap: () => Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) =>DetailsProductsScreen(index: index, prd: entity[index]),
            // )),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(sizeW(context) * 0.32, sizeH(context) * 0.042),
                maximumSize: Size(sizeW(context) * 0.32, sizeH(context) * 0.042),
                backgroundColor:themeCubit.isDark ? theme(context).canvasColor : theme(context).backgroundColor,
                shadowColor: theme(context).dialogBackgroundColor,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: ()=>context.navigation(context, DetailsScreen(data: entity[index])),
              child: Center(
                  child: Text('Details'.tr(),
                      style: theme(context).textTheme.titleSmall!.copyWith(
                          color: theme(context).focusColor,
                          fontFamily: 'arabic'))),
            ),
          ),
        )
      ]),
    ),
  );
}

// Widget oneSliderItem( List<ProductsEntity>? entity, int index, BuildContext context) {
//   ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: false);
//   return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 10),
//     color: theme(context).colorScheme.secondary.withOpacity(0.01),
//     // color: Colors.amber,
//     child: InkWell(
//       onTap: ()  =>context.navigation(context, DetailsScreen(data: entity[index])),
//       child: Stack(children: [
//         // ? container background
//         Align(
//           // alignment: Alignment.bottomCenter,
//           child: Container(
//             // margin: EdgeInsets.only(bottom: sizeH(context)*0.075),
//             // margin: EdgeInsets.only(bottom: sizeH(context)*0.025),
//             height: sizeW(context) * 0.7,
//             decoration: BoxDecoration(
//                 // color: Color(0xff0a75f0),
//                 gradient:RadialGradient(colors: [
//                         theme(context).colorScheme.secondary,
//                         theme(context).primaryColor,
//                         theme(context).primaryColor,
//                         theme(context).colorScheme.secondary,
//                       ], radius: 1.3, center: const Alignment(0.5, -0.5)),
//                 borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
//         // ? image ,text
//         Column(
//           children: [
//             //? image
//             Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 // margin: const EdgeInsets.only(top: 2),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     // color: theme(context).canvasColor,
//                     color:theme(context).backgroundColor,
//                     ),
//                 alignment: Alignment.topCenter,
//                 height: sizeH(context) * 0.25,
//                 width: sizeW(context) * 0.42,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: cachedImageWidget(context, entity![index].image!,
//                       sizeW(context) * 0.34, sizeH(context) * 0.22),
//                 ),
//               ),
//             ),
//             //? text
//             Container(
//                 alignment: Alignment.centerLeft,
//                 margin: const EdgeInsets.only(top: 15, left: 25),
//                 child: Text(entity[index].title!.toString(),
//                     style: theme(context).textTheme.displayLarge!.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color:themeCubit.isDark ? theme(context).focusColor : theme(context).canvasColor,
//                       fontSize: sizeH(context)*0.018,))),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: const EdgeInsets.only(top: 5, left: 25),
//               child: Text(
//                 " ${entity[index].price!.toString()} \$",
//                 style: theme(context).textTheme.displayMedium!.copyWith(color: themeCubit.isDark ? theme(context).focusColor : theme(context).canvasColor,fontSize: sizeH(context)*0.02),
//               ),
//             ),
//           ],
//         ),
//         //? button
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: InkWell(
//             // onTap: () => Navigator.of(context).push(MaterialPageRoute(
//             //   builder: (context) =>DetailsProductsScreen(index: index, prd: entity[index]),
//             // )),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(sizeW(context) * 0.32, sizeH(context) * 0.042),
//                 maximumSize: Size(sizeW(context) * 0.32, sizeH(context) * 0.042),
//                 backgroundColor: theme(context).backgroundColor,
//                 shadowColor: theme(context).dialogBackgroundColor,
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               onPressed: ()=>context.navigation(context, DetailsScreen(data: entity[index])),
//               child: Center(
//                   child: Text('Details'.tr(),
//                       style: theme(context).textTheme.titleSmall!.copyWith(
//                           color: theme(context).focusColor,
//                           fontFamily: 'arabic'))),
//             ),
//           ),
//         )
//       ]),
//     ),
//   );
// }
