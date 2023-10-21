import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/animation/staggred_animation/list_view_animation.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/main_screens/presentation/screen/category_list_products_screen.dart';

import '../../../../core/common/constans/images.dart';
import '../../../../core/common/constans/texts.dart';
import '../../../../core/common/router.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).backgroundColor : theme(context).canvasColor,
      body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: sizeH(context) * 0.05),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1 / 1.2),
              itemCount: 6,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 10,
                    child: FadeInAnimation(
                      child: InkWell(
                        onTap: (){
                          CategoryListOfPrdRouter data = CategoryListOfPrdRouter(
                             title: kCategoryText[index],
                             image: kHomeCategoryImages[index],
                             endPoint: kHomeCategoryEndPoints[index]
                          );
                          // context.beamToNamed('/listOfPrd' , data: data);
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryListProductsScreen(data: data),));
                          context.navigation(context, CategoryListProductsScreen(data: data));
                        },
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow:  [
                                    BoxShadow(
                                        blurRadius: 6,
                                        blurStyle: BlurStyle.normal,
                                        spreadRadius: 0,
                                        offset:const Offset(-1, 3),
                                        color:BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).backgroundColor : theme(context).focusColor.withOpacity(0.2)
                                        )
                                  ],
                                  color: theme(context).canvasColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                      kCategoryImages[index],
                                      width: sizeW(context) * 0.34,
                                      height: sizeH(context) * 0.12,
                                      color: theme(context).primaryColor,
                                    )),
                                    sizeBoxH(10),
                                    Text(
                                      kCategoryText[index].tr(),
                                      style:theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).focusColor,fontSize: 18),
                                    )
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
    );
  }
}
