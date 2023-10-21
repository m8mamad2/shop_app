import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/animation/staggred_animation/list_view_animation.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/cached_image.dart';
import 'package:project3/src/view/main_screens/presentation/screen/details_screen.dart';
import 'package:project3/src/view/main_screens/presentation/widget/home_widget/home_title_prd_widget.dart';

import '../../../../../core/common/constans/size.dart';
import '../../../domain/entities/products_entity.dart';

Widget homeCollectionWidget(BuildContext context, String title, List<ProductsEntity> data) => Padding(
      padding: isEnglish(context)
          ? EdgeInsets.only(left: sizeW(context) * 0.037)
          : EdgeInsets.only(right: sizeW(context) * 0.037),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: homeTitleOfCollectionWidget(context, title),
          ),
          SizedBox(
            height: sizeH(context) * 0.2,
            child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ListViewAnimatinoWidget(
                    index: index,
                    child: oneCollectionWidget(data, index, context))),
          ),
        ],
      ),
    );

Widget oneCollectionWidget(List<ProductsEntity>? entity, int index, BuildContext context) {    
  ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context,listen: false);
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: InkWell(
        onTap: () => context.navigation(context, DetailsScreen(data: entity[index])),
        child: Container(
            color: themeCubit.isDark ? theme(context).backgroundColor : theme(context).canvasColor,
            child: Column(children: [
              SizedBox(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Container(
                    width: sizeW(context) * 0.34,
                    color:themeCubit.isDark ? theme(context).canvasColor : theme(context).backgroundColor,
                    child: cachedImageWidget(context, entity![index].image!,
                        sizeW(context) * 0.25, sizeH(context) * 0.12),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // color: Color(0xff0a75f0),
                  gradient: LinearGradient(colors: [
                    theme(context).primaryColor,
                    theme(context).primaryColor.withOpacity(0.8)
                      ],begin: Alignment.bottomCenter,end: Alignment.topCenter)
                  
                ),
                width: sizeW(context) * 0.34,
                height: sizeH(context) * 0.06,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entity[index].title!.toString(),
                        style: theme(context).textTheme.bodyLarge!.copyWith(color: themeCubit.isDark ? theme(context).focusColor : theme(context).canvasColor,fontSize: sizeH(context)*0.014),
                      ),
                      Text(
                        '${entity[index].price!.toString()}\$',
                        style: theme(context).textTheme.headlineLarge!.copyWith(
                          color: themeCubit.isDark ? theme(context).focusColor : theme(context).canvasColor,
                          fontSize: sizeH(context)*0.014),
                      ),
                    ]),
              )
            ])),
      ),
    );
}