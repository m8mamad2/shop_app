import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:project3/src/core/common/constans/lottie.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/constans/texts.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/view/main_screens/domain/entities/payment_card_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/cart_db_bloc/cart_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/products_bloc/products_bloc.dart';

import '../../../../config/theme/theme.dart';

class SuccessPaymentScreen extends StatelessWidget {
  final PaymentCardEntity data;
  const SuccessPaymentScreen({super.key , required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:theme(context).canvasColor,
      appBar: AppBar(
        toolbarHeight: sizeH(context)*0.1,
        elevation: 0,
        leading: const SizedBox.shrink(),
        backgroundColor: theme(context).canvasColor,
        title:Text('Successful'.tr(),
        style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor),),centerTitle: true,),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sizeBoxH(sizeH(context)*0.04,),
            Text('The purchase was successful'.tr(),
            textAlign: TextAlign.center,
              style: theme(context).textTheme.headlineLarge!.copyWith(
                fontSize: sizeW(context)*0.05,color: theme(context).focusColor),),
            SizedBox(
              height: sizeH(context)*0.3,
              width: sizeW(context),
              child: kSuccessPaymentLottie,
            ),
            Container(
              margin: EdgeInsets.only(top: sizeH(context)*0.34),
              child: ElevatedButton(
                onPressed: (){
                  context.navigation(context,const BottomNavigateWidget());
                  BlocProvider.of<CartDbBloc>(context).add(ClearFromCartDBEvent());
                  context.read<ProductsBloc>().add(ApiCallProductsEvent(endPoint: 'products'));
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  minimumSize: Size(sizeW(context)*0.7, sizeH(context)*0.07)
                ),
                child: Text(
                  'continue'.tr(),
                  style: theme(context).textTheme.titleMedium!.copyWith(color: theme(context).backgroundColor),)),
            )
        ]),
      ),
    );
  }
}