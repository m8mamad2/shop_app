import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/animation/staggred_animation/list_view_animation.dart';
import 'package:project3/src/core/common/constans/lottie.dart';
import 'package:project3/src/core/common/constans/texts.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/core/widget/error_bloc.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/main_screens/domain/entities/cart_db_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/cart_db_bloc/cart_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/screen/check_out_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/checkout_check_logged.dart';

import '../../../../core/common/constans/icons.dart';
import '../../../../core/common/constans/size.dart';

class CartScreen extends StatefulWidget {
  final bool isBottomNavbar;
  CartScreen({super.key, required this.isBottomNavbar});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late num res;
  
  @override
  void initState() {
    BlocProvider.of<CartDbBloc>(context).add(InitialCartDBEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: theme(context).backgroundColor,
          elevation: 0,
          leading: widget.isBottomNavbar
              ? Container()
              : IconButton(
                  icon: kArrowIcon(context, theme(context).primaryColor),
                  onPressed: () => context.navigationBack(context),
                ),
          actions: [
            IconButton(
                onPressed: () => BlocProvider.of<CartDbBloc>(context).add(ClearFromCartDBEvent()),
                icon:  Icon(Icons.delete,color: theme(context).focusColor,))
          ],
        ),
        body: BlocBuilder<CartDbBloc, CartDbState>(
          builder: (context, state) {
            if (state is LoadingCartDBState) return loading(context);
            if (state is SuccessCartDBState) {
              List<CartDBEntity> data = state.data;
              late num total = (data
                .map((item) => item.houmuch * item.price)
                .reduce((value1, value2) => value1 + value2));


              return data.isEmpty
                  ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: sizeW(context)*0.9,child: themeCubit.isDark ? kDarkEmptyLottie : kLightEmptyLottie),
                      sizeBoxH(sizeH(context)*0.03),
                      Text('Your Cart is Empty'.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).focusColor,fontSize: sizeW(context)*0.05),)
                    ],
                  ))
                  : Column(children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {

                            CartDBEntity oneData = data[index];
                            res = oneData.price * oneData.houmuch;
    
                            return ListViewAnimatinoWidget(
                              index: index,
                              child: Slidable(
                                startActionPane: ActionPane(
                                  motion: const DrawerMotion(), 
                                  children: [
                                    SlidableAction(
                                      autoClose: true,
                                      borderRadius: isEnglish(context) 
                                        ? const BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25))
                                        : const BorderRadius.only(bottomLeft: Radius.circular(15),topLeft: Radius.circular(25)),
                                      backgroundColor: theme(context).primaryColor,
                                      foregroundColor: theme(context).backgroundColor,
                                      icon: Icons.delete,
                                      label: 'Delete'.tr(),
                                      onPressed:(context) => showDialog(
                                        context: context, 
                                        builder:(context) => AlertDialog(
                                          backgroundColor: theme(context).backgroundColor,
                                          alignment: Alignment.center,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: sizeH(context)*0.03,top: sizeH(context)*0.01),
                                            child: Center(child: Text('Are you sure about removing this?'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontWeight: FontWeight.bold,fontSize: sizeW(context)*0.04),)),
                                          ),
                                          actions: [ 
                                            Padding(
                                              padding: EdgeInsets.only(top: sizeH(context)*0.03,bottom: sizeH(context)*0.01),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  deleteDialogButton(false,index,() => context.navigationBack(context)),
                                                  deleteDialogButton(true, index,() {
                                                    BlocProvider.of<CartDbBloc>(context).add(DeleteFromCartDBEvent(index:index));
                                                    context.navigation(context, const BottomNavigateWidget(selected: 2,));
                                                    BlocProvider.of<ProductsBloc>(context).add(ApiCallProductsEvent(endPoint: kproducts));
                                                    }
                                                  )
                                                  ,
                                                ],
                                              ),
                                            )
                                          ],
                                        )), )
                                  ]),
                                
                                child: Center(
                                  child: SizedBox(
                                    width: sizeW(context)*0.94,
                                    child: Card(
                                      shadowColor: Colors.black,
                                      elevation: 6,
                                      color: theme(context).canvasColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      child: Row(children: [
                                        
                                        //* image
                                        Stack(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: theme(context).focusColor,
                                              radius: sizeW(context)*0.09,
                                              child: CircleAvatar(
                                                backgroundColor: theme(context).backgroundColor,
                                                radius: sizeW(context)*0.087,
                                                child: CircleAvatar(
                                                  backgroundColor: theme(context).focusColor,
                                                  radius: sizeW(context)*0.08,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsProductsScreen(index: index,oneData: entity,),)),
                                              child: Image.network(
                                                oneData.image,
                                                width: sizeW(context) * 0.19, //70
                                                height: sizeH(context) * 0.093, //70
                                              ),
                                            )
                                          ],
                                        ),
                                        sizeBoxW(sizeW(context)*0.08),
                                                              
                                        //* titles
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Text(oneData.title,style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor ,fontWeight: FontWeight.bold)),
                                              sizeBoxH(sizeH(context)*0.01),
                                              CircleAvatar(backgroundColor: Color( int.parse(oneData.color)),radius: 10),
                                              sizeBoxH(sizeH(context)*0.01),
                                              Text(oneData.size.toString(),style: theme(context).textTheme.bodySmall!.copyWith(color: theme(context).focusColor),),
                                              sizeBoxH(sizeH(context)*0.01),
                                              Text('\$ $res',style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: 18,color: theme(context).focusColor),),
                                            ],
                                          ),
                                        ),
                                                              
                                        //* icons
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            children: [
                                              cartCounterButton(() {oneData.houmuch++;},
                                                  kAddIcon,
                                                  theme(context).primaryColor,
                                                  false),
                                              Text((
                                                  oneData.houmuch == 0 ||oneData.houmuch <= 0
                                                        ? oneData.houmuch = 0
                                                        : oneData.houmuch).toString(),
                                                style: theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).focusColor,fontSize: 20)
                                              ),
                                              cartCounterButton(() {
                                                if (oneData.houmuch == 1) {BlocProvider.of<CartDbBloc>(context).add(DeleteFromCartDBEvent(index: index));}
                                                else {oneData.houmuch--;}},
                                                kRemoveIcon,
                                                theme(context).backgroundColor,
                                                true)
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      widget.isBottomNavbar
                          ? Container(
                              margin:EdgeInsets.only(bottom: sizeH(context) * 0.02),
                              decoration: BoxDecoration(
                                  boxShadow:const [
                                    BoxShadow(
                                        blurRadius: 6,
                                        blurStyle: BlurStyle.normal,
                                        spreadRadius: 0,
                                        offset: Offset(0, -2),
                                        color: Colors.black26)
                                  ],
                                  color: theme(context).canvasColor,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(12),
                              height: sizeH(context) * 0.143,
                              width: sizeW(context) * 0.95,
                              child: Padding(
                                padding:  EdgeInsets.only(bottom: sizeH(context)*0.05),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text.rich(TextSpan(
                                        style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: sizeW(context)*0.045,color: theme(context).focusColor),
                                        children: [
                                        TextSpan(text: 'Total: '.tr()),
                                        TextSpan(text: ' ${(data.map((item) => item.houmuch * item.price).reduce((value1, value2) => value1 + value2))}\$')
                                      ])),
                                      const Spacer(),
                                      ElevatedButton(
                                        // onPressed: () => context.beamToNamed('/checkout',data: total),
                                        onPressed: () => context.navigation(context, CheckoutCheckLogged(total: total)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: theme(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:BorderRadius.circular(50)),
                                              minimumSize: Size(
                                                  sizeW(context) * 0.34,
                                                  sizeH(context) * 0.045),
                                        ),
                                        child: Text(
                                          'continue'.tr(),
                                          style: theme(context).textTheme.titleSmall!.copyWith(color:BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).focusColor : theme(context).canvasColor)
                                        ),
                                      )
                                    ]),
                              ))
                          : Container(
                              height: sizeH(context) * 0.155,
                              width: sizeW(context) * 0.93,
                              decoration: BoxDecoration(
                                color: theme(context).primaryColor,
                                borderRadius:const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '\$ ${(data.map((item) => item.houmuch * item.price).reduce((value1, value2) => value1 + value2))}',
                                      style: theme(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                              color:themeCubit.isDark ? theme(context).focusColor : theme(context).backgroundColor,fontSize: 17),
                                    ),
                                    Text.rich(TextSpan(
                                        style: theme(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontSize: 15,color: themeCubit.isDark ? theme(context).focusColor : theme(context).backgroundColor),
                                        children: [
                                          TextSpan(text: 'items'.tr()),
                                          TextSpan(text: '   ${data.length}  '),
                                        ]))
                                  ],
                                ),
                                sizeBoxH(sizeH(context)*0.01),
                                ElevatedButton(
                                  onPressed: () =>context.navigation(context, CheckOutScreen(total: total)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:theme(context).canvasColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    minimumSize: Size(sizeW(context) * 0.75,sizeH(context) * 0.05),
                                  ),
                                  child: Text(
                                    'continue'.tr(),
                                    style: theme(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: theme(context).primaryColor),
                                  ),
                                )
                              ]),
                            )
                    ]);
            }
            if (state is FailCartDBState) return const ErrorBlocWidget();
            return  const SizedBox();
          },
        ),
      ),
    );
  }
  ElevatedButton cartCounterButton(void Function() setStatee, IconData icon, Color color, bool isRemove) =>
      ElevatedButton(
          onPressed: () {setState(setStatee);},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(30, 30),
            backgroundColor: color,
            shape: const CircleBorder(),
          ),
          child: FittedBox(
            child: Icon(icon,
                color: isRemove
                    ? theme(context).primaryColor
                    : theme(context).backgroundColor),
          ));


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
