// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hive/hive.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/animation/staggred_animation/list_view_animation.dart';
import 'package:project3/src/core/common/constans/icons.dart';
import 'package:project3/src/core/common/constans/texts.dart';
import 'package:project3/src/core/common/router.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/badge.dart';
import 'package:project3/src/core/widget/cached_image.dart';
import 'package:project3/src/core/widget/drawer.dart';
import 'package:project3/src/view/main_screens/data/data_source/local/init_hive_db.dart';
import 'package:project3/src/view/main_screens/domain/entities/favorite_db_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/favorite_db_bloc/favorite_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/screen/home_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/common/constans/size.dart';
import '../../../../core/widget/error_bloc.dart';
import '../../../../core/widget/loading.dart';
import '../../domain/entities/products_entity.dart';
import 'details_screen.dart';

class CategoryListProductsScreen extends StatefulWidget {

  CategoryListOfPrdRouter data;

  CategoryListProductsScreen({Key? key, required this.data,/*required this.title,required this.image,required this.endPoint*/})
      : super(key: key);

  @override
  State<CategoryListProductsScreen> createState() => _CategoryListProductsScreenState();
}

class _CategoryListProductsScreenState extends State<CategoryListProductsScreen> {
  TextEditingController controller = TextEditingController();
  List<ProductsEntity>? ulist = [];
  late FavoriteDBEntity favoriteDBEntity;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoriteDbBloc>(context).add(InitialFavoriteDBEvent());
    BlocProvider.of<ProductsBloc>(context).add(ApiCallProductsEvent(endPoint: widget.data.endPoint));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      _loading();
      });
  }


  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context,listen: false);
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
          key: const Key('listOfProducts'),
          backgroundColor: theme(context).backgroundColor,
          body: BlocBuilder<ProductsBloc,ProductsState>(
            key: UniqueKey(),
            builder: (context, state) {
              if(state is LoadingProductsState)return loading(context);
              if(state is SuccessProductsState){
                List<ProductsEntity> productsState = state.data;
                ulist = List.from(state.data);
                return SafeArea(
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [categoryListPrdAppBarWidget(context)],
                      body: Column(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: MasonryGridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              key: UniqueKey(),
                              itemCount: state.data.length,
                              itemBuilder: (context, index) {
                  
                                
                                final height = index % 2 == 0 ? 200 : 160;
                                final heightBool = index % 2 == 0 ? true : false;
                                favoriteDBEntity = FavoriteDBEntity.fromProductsEntity(state.data[index]);
                  
                                
                  
                                return _isLoading 
      
                                ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                  child: SizedBox(
                                    height: height.toDouble(),
                                    width: double.infinity,
                                    child: Shimmer.fromColors(
                                      baseColor: themeCubit.isDark ? Colors.black12: theme(context).canvasColor ,
                                      highlightColor: themeCubit.isDark ? Colors.white12 : Colors.grey.shade300,
                                      child: Container(color: theme(context).canvasColor,), 
                                      ),),
                                )
                                
                                : ListViewAnimatinoWidget(
                                  index: index,
                                  child: InkWell(
                                    onTap: () =>context.navigation(context, DetailsScreen(data: state.data[index])),
                                    child: Stack(children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                          child: Container(
                                            height: height.toDouble(),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 6,
                                                      color:BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).canvasColor.withOpacity(0.5) : theme(context).focusColor.withOpacity(0.5),
                                                      offset:const Offset(3, 3)),
                                                ],
                                                color: theme(context).canvasColor,
                                                borderRadius: BorderRadius.circular(20)),
                                            width: double.infinity,
                                            child: Column(
                                              key: UniqueKey(),
                                              children: [
                                                cachedImageWidget(
                                                    context,
                                                    state.data[index].image!,
                                                    sizeW(context) * 0.32,
                                                    heightBool ? sizeH(context) * 0.13 : sizeH(context) * 0.11),
                                                const Spacer(),
                                                Center(
                                                  child: Container(
                                                      key: UniqueKey(),
                                                      decoration: BoxDecoration(
                                                        borderRadius: isEnglish(context)
                                                            ? const BorderRadius.only(
                                                                topRight:Radius.circular(10),
                                                                topLeft:Radius.circular(10))
                                                            : const BorderRadius.only(
                                                                topLeft:Radius.circular(10)),
                                                      ),
                                                      width: sizeW(context) * 0.29,
                                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                                      child: Column(
                                                          crossAxisAlignment:CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              state.data[index].title!,
                                                              style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor)
                                                            ),
                                                            Text(
                                                              '\$${state.data[index].price!.toString()}',
                                                              style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: sizeW(context)*0.04,color: theme(context).primaryColor)
                                                            ),
                                                          ])
                                                          ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      
                                      BlocBuilder<FavoriteDbBloc, FavoriteDbState>(
                                        builder: (context, state) {
                                          if (state is SuccessFavoriteDBState || state is LoadingFavoriteDBState) {
                                            
                                            FavoriteDBEntity favoriteDBEntity = FavoriteDBEntity.fromProductsEntity(productsState[index]);
                                            bool isFavorite =  boxList[1].containsKey(productsState[index].id);
      
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                      onTap: () async{
                                                        isFavorite  
                                                          ? BlocProvider.of<FavoriteDbBloc>(context).add(DeleteFromFavoriteDBEvent(index: productsState[index].id!))
                                                          : BlocProvider.of<FavoriteDbBloc>(context).add(AddToFavoriteDBEvent(favoriteDBEntity: favoriteDBEntity));
                                                      },
                                                      child: CircleAvatar(
                                                          radius: 18,
                                                          backgroundColor: theme(context).primaryColor,
                                                          child: Icon(
                                                            isFavorite
                                                                ? Icons.favorite
                                                                : Icons.favorite_border_outlined,
                                                            color:BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).focusColor : theme(context).backgroundColor,
                                                            size: 17,
                                                          )))),
                                            );}
                                          if (state is FailFavoriteDBState)return Text(state.error!);
                                          return const Text('data');
                                        },
                                      ),
      
                                    ]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                    ));
              }
              if(state is FailProductsState)return const ErrorBlocWidget();
              return Container();
            }
            
          )),
    );
  }

  SliverToBoxAdapter categoryListPrdAppBarWidget(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context,listen: false);
    return SliverToBoxAdapter(
            child: Container(
            decoration:BoxDecoration(
                color: Colors.transparent,
                borderRadius:const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.data.image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode( Colors.black.withOpacity(0.2), BlendMode.colorBurn))),
            padding:const EdgeInsets.symmetric(horizontal: 14),
            height: sizeH(context) * 0.25,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizeBoxH(10),
                  //! icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () { 
                          context.navigationBack(context);
                          BlocProvider.of<ProductsBloc>(context).add(ApiCallProductsEvent(endPoint: kproducts));
                          },
                        icon: kArrowIcon(context,themeCubit.isDark ? theme(context).focusColor: theme(context).backgroundColor),
                        color: theme(context).backgroundColor,
                      ),
                      Badge(color: themeCubit.isDark ? theme(context).focusColor: theme(context).backgroundColor,)
                    ],
                  ),
                  //! title
                  sizeBoxH(18),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeW(context)*0.05),
                    child: Text(
                      widget.data.title.tr(),
                      style: theme(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: sizeW(context)*0.06,color: themeCubit.isDark ? theme(context).focusColor: theme(context).backgroundColor),
                    ),
                  ),
                  sizeBoxH(8),
                  //! search bar
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: theme(context).canvasColor,
                          borderRadius: BorderRadius.circular(30)),
                      width: sizeW(context) * 0.85,
                      height: sizeH(context)*0.056,
                      child: TypeAheadField<String>(
                        noItemsFoundBuilder: (context) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '😐 sorry... not Found'.tr(),
                              style: theme(context).textTheme.titleMedium!.copyWith(color: theme(context).focusColor),
                            ),
                          ),
                        ),
                        loadingBuilder: (context) =>loading(context),
                        textFieldConfiguration: TextFieldConfiguration(
                            controller: controller,
                            style: theme(context).textTheme.titleMedium!.copyWith(fontSize: 18,color: theme(context).focusColor),
                            decoration: InputDecoration(
                                iconColor:theme(context).primaryColor,
                                border: InputBorder.none,
                                contentPadding:const EdgeInsets.all(5),
                                hintStyle: theme(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: themeCubit.isDark ? theme(context).focusColor: theme(context).focusColor,fontSize: sizeW(context)*0.04),
                                hintText: 'Search'.tr(),
                                icon: Padding(
                                  padding: EdgeInsets.only(left: isEnglish(context)? sizeW(context)*0.035:0 ,right: isEnglish(context)?0:sizeW(context)*0.035),
                                  child:const Icon(Icons.search),
                                ))),
                        suggestionsCallback: (pattern) async {
                          return await getSuggestion(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Padding(
                              padding:const EdgeInsets.symmetric(horizontal: 35),
                              child: Text(
                                suggestion,
                                style:theme(context).textTheme.titleMedium!.copyWith(color: theme(context).focusColor),
                              ),
                            ),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          controller.text = suggestion;
                          ProductsEntity data = ulist!.firstWhere((element) => element.title == suggestion);
                          context.navigation(context, DetailsScreen(data: data));
                        },
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  )
                ]),
          ));
  }
  
  Future<bool> willPop()async{
    BlocProvider.of<ProductsBloc>(context).add(ApiCallProductsEvent(endPoint: kproducts));
    return true;
  }

  getSuggestion(String? query) {
    List<String> strings = ulist!.map((e) => e.title!).toList();
    print(strings);
    List<String> matches = [];
    matches.addAll(strings);
    matches.retainWhere( (element) => element.toLowerCase().contains(query!.toLowerCase()));
    return matches;
  }

  Future _loading()async{await Future.delayed(const Duration(seconds: 4), (){if(mounted)  setState(() {_isLoading = false;});});}

}
