// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, iterable_contains_unrelated_type, prefer_typing_uninitialized_variables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/core/common/details_router_object.dart';
import 'package:project3/src/core/common/top_snack_bar.dart';
import 'package:project3/src/view/main_screens/data/data_source/local/init_hive_db.dart';
import 'package:project3/src/view/main_screens/domain/entities/cart_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/entities/favorite_db_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/cart_db_bloc/cart_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/favorite_db_bloc/favorite_db_bloc.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/common/constans/size.dart';
import '../../../../core/widget/error_bloc.dart';
import '../../../../core/widget/loading.dart';
import '../../domain/entities/products_entity.dart';
import '../widget/details_widget/details_description_widget.dart';
import '../widget/details_widget/details_image_background_widget.dart';
import '../widget/details_widget/details_see_cart_widget.dart';

class DetailsScreen extends StatefulWidget {
  ProductsEntity data;
  DetailsScreen({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  
  //!pciker things
  List<bool> isChoeseSize = [];
  bool isChoeseForContinueSize = false;
  late var choeseSize;
  List<bool> isChoeseColor = [];
  bool isChoeseForContinueColor = false;
  late var choeseColor;

  late ProductsEntity data;
  late Color dataColor;
  late CartDBEntity cartDBEntity;
  late FavoriteDBEntity favoriteDBEntity;

  @override
  void initState() {
    data = widget.data;
    dataColor = Color(int.parse(widget.data.color!));
    cartDBEntity = CartDBEntity.fromProductsEntity(widget.data);
    favoriteDBEntity = FavoriteDBEntity.fromProductsEntity(widget.data);
    

    BlocProvider.of<CartDbBloc>(context).add(InitialCartDBEvent());
    BlocProvider.of<FavoriteDbBloc>(context).add(InitialFavoriteDBEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme(context).canvasColor,
      body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //!image and title
          DetialsImageAndBackgroudWidget(data: data, dataColor: dataColor),
          sizeBoxH(sizeH(context) * 0.05),

          //!picker
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,),
            child: Row(
              children: [
                //* choese color
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                    child: Text('Color'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontSize: 17,fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: sizeW(context) * 0.44,
                    height: sizeH(context) * 0.054,
                    child: GridView.builder(
                      itemCount: widget.data.colors!.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        isChoeseColor.add(false);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isChoeseColor.replaceRange(
                                  0, isChoeseColor.length, [
                                for (int i = 0; i < isChoeseColor.length; i++)
                                  false
                              ]);
                              isChoeseColor[index] = true;
                              isChoeseForContinueColor = true;
                              choeseColor = widget.data.colors![index];
                            });
                          },
                          child: CircleAvatar(
                            maxRadius: 19.5,
                            backgroundColor: isChoeseColor[index]
                                ? Color(int.parse(widget.data.colors![index]))
                                : theme(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              // backgroundColor:Colors.black,
                              backgroundColor: theme(context).canvasColor,
                              radius: 19,
                              child: CircleAvatar(
                                backgroundColor: Color(int.parse(widget.data.colors![index])),
                                radius: 15,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]),

                //* choese size
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 7),
                    child: Text('Size'.tr(),
                        style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontSize: 17,fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: sizeW(context) * 0.44,
                    height: sizeH(context) * 0.06,
                    child: GridView.builder(
                      itemCount: widget.data.size!.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        isChoeseSize.add(false);
                        return GestureDetector(
                          onTap: () {
                            isChoeseSize.replaceRange(0, isChoeseSize.length, [
                              for (int i = 0; i < isChoeseSize.length; i++)
                                false
                            ]);
                            isChoeseSize[index] = true;
                            isChoeseForContinueSize = true;
                            choeseSize = widget.data.size![index];
                            setState(() {});
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            shadowColor:BlocProvider.of<ThemeCubit>(context).isDark 
                            ? theme(context).backgroundColor
                            : theme(context).focusColor.withOpacity(0.3),
                            elevation: 4,
                            color: isChoeseSize[index]
                                ? theme(context).primaryColor
                                : theme(context).dialogBackgroundColor,
                            child: Center(
                              child: Text(widget.data.size![index].toString(),
                                  style: theme(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: isChoeseSize[index]
                                              ? theme(context).backgroundColor
                                              : theme(context).focusColor)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]),
              ],
            ),
          ),
          DetailsDescriptionWidget(context, data),

          //! buttons
          BlocBuilder<CartDbBloc, CartDbState>(
            builder: (context, state) {
              if (state is LoadingCartDBState) return loading(context);
              if (state is SuccessCartDBState) {
                //* boxlist[0] == product Box
                
                if (boxList[0].containsKey(data.id)) {return detailsSeeCartWidget(context, dataColor);}
                
                else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //! add to cart button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: InkWell(
                          onTap: () {
                            //!اصلی
                            if(isChoeseForContinueColor == true && isChoeseForContinueSize == true) {
                                  cartDBEntity.color = choeseColor;
                                  cartDBEntity.size = choeseSize;
                                  BlocProvider.of<CartDbBloc>(context).add(AddToCartDBEvent(data: cartDBEntity));}
                            else {showSnackBarOnTop(
                                    context,
                                    isChoeseForContinueColor == false
                                        ? 'Please choose a color'.tr()
                                        : 'Please choose a size'.tr());}
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: dataColor,
                              ),
                              height: sizeH(context) * 0.06,
                              width: sizeW(context) * 0.75,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add To Cart'.tr(),
                                    style: theme(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color:theme(context).backgroundColor,
                                            fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.add,
                                    color: theme(context).backgroundColor,
                                  ),
                                ],
                              )),
                        ),
                      ),
                      
                      //! favorite button
                      BlocBuilder<FavoriteDbBloc, FavoriteDbState>(
                        builder: (context, state) {
                          if (state is LoadingFavoriteDBState)return loading(context);
                          if (state is SuccessFavoriteDBState) {
                            bool isFavoriteState = boxList[1].containsKey(data.id);
                            return ElevatedButton(
                              onPressed: () async{
                                setState(() =>isFavoriteState = !isFavoriteState);
                                isFavoriteState
                                    ? BlocProvider.of<FavoriteDbBloc>(context).add(AddToFavoriteDBEvent(favoriteDBEntity: favoriteDBEntity))
                                    : BlocProvider.of<FavoriteDbBloc>(context).add(DeleteFromFavoriteDBEvent(index: data.id!));
                                    
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(sizeW(context) * 0.1,sizeH(context) * 0.06),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:theme(context).dialogBackgroundColor,
                                  shadowColor: BlocProvider.of<ThemeCubit>(context).isDark
                                  ? theme(context).backgroundColor
                                  : theme(context).focusColor.withOpacity(0.7),
                                  elevation: 4),
                              child: Icon(
                                isFavoriteState
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: theme(context).focusColor,
                              ),
                            );
                          }
                          if (state is FailFavoriteDBState)return Text(state.error.toString());
                          return const Text('data');
                        },
                      ),
                    ],
                  );
                }
              }
              if (state is FailCartDBState) return const ErrorBlocWidget();
              return const Text('error');
            },
          ),
        ],
      ),
    ));
  }

//!snack bar
}
