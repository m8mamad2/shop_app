import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:project3/src/core/common/constans/images.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/screen/login_screen.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/screen/signup_screen.dart';

import '../../config/theme/cubit_changer/theme_cubit.dart';
import '../../config/theme/theme.dart';
import '../common/constans/size.dart';

class AuthInApp extends StatelessWidget {
  const AuthInApp({super.key});

  @override
  Widget build(BuildContext context) {

    ThemeCubit themeCubit = BlocProvider.of(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme(context).backgroundColor,
        body: Column(
          children: [
            Stack(children: [
            RotatedBox(
              quarterTurns: 2,
              child: ClipPath(
                clipper: RoundedDiagonalPathClipper(),
                child: Container(
                  height: sizeH(context)*0.17,
                  color: theme(context).primaryColor.withOpacity(0.75),
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: ClipPath(
                clipper: RoundedDiagonalPathClipper(),
                child: Container(
                  color: theme(context).primaryColor,
                  height: sizeH(context)*0.14,
                ),
              ),
            ),
            ],),
            Center(
              child: Column(
                children: [
                  Image.asset(themeCubit.isDark ? kDarkLogoImage : kLightLogoImage,width: sizeW(context) * 0.6,height: sizeH(context)*0.27,),
                  sizeBoxH(sizeH(context)*0.17),
                  SizedBox(
                    width: sizeW(context)*0.75,
                    child: Text('Please register or login to continue'.tr(),textAlign: TextAlign.center,style: theme(context).textTheme.titleMedium!.copyWith(fontSize: 17),)),
                  SizedBox(height: sizeH(context)*0.04,),
                  ElevatedButton(
                    onPressed:()=> context.navigation(context,const LoginScreen()),
                    
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: theme(context).primaryColor,
                      minimumSize: Size(sizeW(context)*0.7, sizeH(context)*0.055,),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ), 
                    child: Text('Login'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color:theme(context).canvasColor,fontSize: 13),),
                  ),
                  sizeBoxH(5),
                  ElevatedButton(
                    onPressed: () => context.navigation(context,const SignupScreen()),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: theme(context).backgroundColor,
                      minimumSize: Size(sizeW(context)*0.7, sizeH(context)*0.055,),
                      shape: RoundedRectangleBorder(side: BorderSide(color: theme(context).primaryColor,width: 0.8),borderRadius: BorderRadius.circular(10))
                    ), 
                    child: Text('signUp'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color:theme(context).primaryColor,fontSize: 13),),
                  ),
                  
                ],
              ),
            ),
        
    
          ],
        ),
    
      ),
    );
  }
}
