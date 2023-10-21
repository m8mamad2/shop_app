import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/constans/texts.dart';
import 'package:project3/src/core/common/precache_image.dart';
import 'package:project3/src/core/widget/drawer.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/widget/home_widget/home_appbar_widget.dart';
import 'package:project3/src/view/main_screens/presentation/widget/home_widget/home_category_widget.dart';
import 'package:project3/src/view/main_screens/presentation/widget/home_widget/home_collection_widget.dart';
import 'package:project3/src/view/main_screens/presentation/widget/home_widget/home_searchbar_widget.dart';
import 'package:project3/src/view/main_screens/presentation/widget/home_widget/home_slider_image.dart';
import 'package:project3/src/view/main_screens/presentation/widget/home_widget/home_slider_widget.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/widget/error_bloc.dart';
import '../widget/home_widget/home_poster.dart';
import '../widget/home_widget/home_vertical_collection_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: false);
    return Container(
      width: sizeW(context),
      height: sizeH(context),
      color:themeCubit.isDark ? theme(context).backgroundColor : theme(context).canvasColor,
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is LoadingProductsState) return loading(context);
          if (state is SuccessProductsState) {
          List<ProductsEntity> data = state.data;
          return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [homeAppbar(context)],
              body: SingleChildScrollView(
                child: Column(  
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    homeSearchBarWidget(context, themeCubit),
                    homeCategoryWidget(context),
                    homeCarsoureSliderWidget(context, data),
                    homeCollectionWidget(context,'Top Selling',data),
                    homePostersWidget(context),
                    homeVerticalCollectionWidget(context, data),
                    homeCollectionWidget(context,'Popular',data,),
                    homeSliderImgae(context),
                    homeCollectionWidget(context,'Last Visit',data,),
                    sizeBoxH(sizeH(context)*0.1)
                  ],
                ),
              ),
            );
              }
          if (state is FailProductsState)return const ErrorBlocWidget();
          return const SizedBox();
        }),
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(label: '',icon: Icon(Icons.abc)),
      //   BottomNavigationBarItem(label: '',icon: Icon(Icons.abc)),
      //   BottomNavigationBarItem(label: '',icon: Icon(Icons.abc)),
      //   BottomNavigationBarItem(label: '',icon: Icon(Icons.abc)),
      // ]),
    );
  }
}


