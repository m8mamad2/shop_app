
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/core/animation/staggred_animation/list_view_animation.dart';
import 'package:project3/src/core/common/constans/icons.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/main_screens/data/repo/favorite_db_repo_body.dart';
import 'package:project3/src/view/main_screens/domain/repo/favorite_db_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/usecse/favorite_db_usecaes.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/favorite_db_bloc/favorite_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/products_bloc/products_bloc.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/common/constans/lottie.dart';
import '../../../../core/common/constans/size.dart';
import '../../../../core/common/constans/texts.dart';
import '../../../../core/widget/bottom_navigatebar_widget.dart';
import '../../domain/entities/favorite_db_entity.dart';

class FavoriteScreen extends StatefulWidget {
  final Widget widget;
  const FavoriteScreen({super.key,required this.widget});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    BlocProvider.of<FavoriteDbBloc>(context).add(InitialFavoriteDBEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: theme(context).backgroundColor,
        elevation: 0,
        actions: [IconButton(icon: Icon(Icons.clear,color: theme(context).primaryColor,),onPressed: () => BlocProvider.of<FavoriteDbBloc>(context).add(ClearFavoriteDBEvent()),),],
        leading: IconButton(onPressed: ()=>context.navigation(context, widget.widget), icon: kArrowIcon(context, theme(context).primaryColor)),),
      body: BlocBuilder<FavoriteDbBloc,FavoriteDbState>(
        builder:(context, state) {
          if(state is LoadingFavoriteDBState)return loading(context);
          if(state is SuccessFavoriteDBState){
            return state.data.isEmpty 
              ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: sizeW(context)*0.9,child: BlocProvider.of<ThemeCubit>(context).isDark ? kDarkEmptyLottie : kLightEmptyLottie),
                      sizeBoxH(sizeH(context)*0.03),
                      Text('Your Favorite is Empty'.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: sizeW(context)*0.06,color: theme(context).focusColor),)
                    ],))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 5),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      FavoriteDBEntity data = state.data[index];
                      return ListViewAnimatinoWidget(
                        index: index,
                        child: Card(
                          color: theme(context).canvasColor,
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Stack(children: [
                            Padding(
                              padding:const EdgeInsets.symmetric(vertical: 15),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: CircleAvatar(
                                    backgroundColor: theme(context).focusColor,
                                    radius: sizeW(context)*0.097,
                                    child: CircleAvatar(
                                      backgroundColor: theme(context).backgroundColor,
                                      radius: sizeW(context)*0.092,
                                      child: CircleAvatar(
                                        backgroundColor: theme(context).focusColor,
                                        radius: sizeW(context)*0.085,
                                      ),
                                    ),
                                  )),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    data.image,
                                    height: sizeH(context) * 0.107,
                                    width: sizeW(context) * 0.2,
                                  ),
                                  sizeBoxH(sizeH(context)*0.01),
                                  Text(data.title,style: theme(context).textTheme.bodyLarge!.copyWith(color: theme(context).focusColor),),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: sizeW(context)*0.06),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('\$ ${data.price}',style: theme(context).textTheme.headlineLarge!.copyWith(
                                            fontSize: sizeW(context)*0.05,color: theme(context).focusColor
                                          ),),
                                          IconButton(
                                          onPressed: ()=> showDialog(
                                            context: context, 
                                            builder: (context) => AlertDialog(
                                              backgroundColor: theme(context).backgroundColor,
                                              alignment: Alignment.center,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                              actions: [ 
                                                Padding(
                                                  padding: EdgeInsets.only(top: sizeH(context)*0.03,bottom: sizeH(context)*0.01),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      
                                                      deleteDialogButton(false,index,() => context.navigationBack(context)),
                                                      deleteDialogButton(true, index,() async {
                                                        FavoriteDBUseCase useCase = FavoriteDBUseCase(FavoriteDBRepoBody());
                                                        // BlocProvider.of<FavoriteDbBloc>(context).add(DeleteFromFavoriteDBEvent(index:data.id));
                                                        await useCase.deleteFromBox(data.id);
                                                        context.navigatiomRemove(context,FavoriteScreen(widget: widget.widget));
                                                        BlocProvider.of<ProductsBloc>(context).add(ApiCallProductsEvent(endPoint: kproducts));
                                                        }
                                                      )
                                                      ,
                                                    ],
                                                  ),
                                                )
                                              ],
                                              title: Padding(
                                              padding: EdgeInsets.only(bottom: sizeH(context)*0.03,top: sizeH(context)*0.01),
                                              child: Center(child: Text('Are you sure about removing this?'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontWeight: FontWeight.bold,fontSize: sizeW(context)*0.04),)),
                                              
                                            ),
                                            )),
                                          icon: Icon(Icons.delete,color: theme(context).primaryColor,),),
                                                    
                                        ]),
                                  )
                                ]),
                          ]),
                        ),
                      );
                    },
                  ),
                );
          }
          if(state is FailFavoriteDBState)return Text(state.error!);
          return Container(width: 200,height: 200,color: Colors.amber,);
          
        }, ),
    );
  }
    Widget deleteDialogButton(bool isDelete,int index,VoidCallback onPress)=>ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:isDelete ? theme(context).primaryColor : theme(context).backgroundColor,
        minimumSize: Size(sizeW(context)*0.25, sizeH(context)*0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: theme(context).primaryColor,width:isDelete ? 0 : 1)
        )
      ),
      onPressed: onPress,
      child: Text(isDelete ? 'Yes'.tr() : 'NO'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(
        color: isDelete ? theme(context).backgroundColor : theme(context).primaryColor
      ),),);

}

// Column(
              //   children: [
              //     Text(state.data[index].title),
              //     IconButton(onPressed: ()async{
              //       Box<FavoriteDBEntity> a = boxList[1] as Box<FavoriteDBEntity>;
              //       await a.delete(state.data[index].id);
              //       // BlocProvider.of<FavoriteDbBloc>(context).add(DeleteFromFavoriteDBEvent(index: index));

              //     }, icon: Icon(Icons.delete))
              //   ],
              