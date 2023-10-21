import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/animation/staggred_animation/list_view_animation.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/cached_image.dart';
import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';
import 'package:project3/src/view/main_screens/presentation/screen/details_screen.dart';
import 'package:project3/src/view/main_screens/presentation/widget/home_widget/home_title_prd_widget.dart';

import '../../../../../config/localization/is_english.dart';
import '../../../../../core/common/constans/size.dart';

Widget homeVerticalCollectionWidget(
BuildContext context, List<ProductsEntity>? data) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: sizeW(context) * 0.037,),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:9.0,vertical: 0),
          child: homeTitleOfCollectionWidget( context,'News',),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListViewAnimatinoWidget(
                index: index,
                child: oneCollectionVerticalWidget(data, index, context)); //orr(data, index);
          },
        ),
        sizeBoxH(sizeH(context) * 0.048,),
      ],
    ),
  );
}

Widget oneCollectionVerticalWidget(List<ProductsEntity>? data, int index, BuildContext context) =>
    InkWell(
      onTap: () => context.navigation(context, DetailsScreen(data: data[index],)),
      child: Container(
        height: sizeH(context) * 0.1,
        color: BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).backgroundColor : theme(context).canvasColor,
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: sizeH(context) * 0.083,
            decoration: BoxDecoration(
              color: theme(context).primaryColor,
              borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: isEnglish(context)
                      ? EdgeInsets.only(left: sizeW(context) * 0.25)
                      : EdgeInsets.only(right: sizeW(context)*0.25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data![index].title!.toString(),
                        style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).canvasColor,fontWeight: FontWeight.w600),
                      ),
                      sizeBoxH(sizeH(context)*0.007),

                      Text('\$${data[index].price!.toString()}',style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: sizeH(context)*0.016,color: theme(context).canvasColor))
                    ],
                  ),
                ),
                const Spacer(),
                Padding(padding:const EdgeInsets.symmetric(horizontal: 10),child: Icon(Icons.arrow_forward_ios_rounded,size: sizeW(context)*0.04,color: theme(context).canvasColor,))
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: cachedImageWidget(context, data[index].image!,
                sizeW(context) * 0.245, sizeH(context) * 0.12),
          ),
        ]),
      ),
    );
