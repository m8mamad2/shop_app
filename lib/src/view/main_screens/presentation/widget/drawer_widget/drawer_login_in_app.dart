import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/core/common/constans/lottie.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/bloc/auth_bloc.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/screen/login_screen.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/screen/signup_screen.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/backend_db_bloc/backend_db_bloc.dart';

import '../../../../../config/theme/theme.dart';
import '../../../../../core/widget/drawer.dart';

class DrawerLoginInApp extends StatefulWidget {
  const DrawerLoginInApp({super.key});

  @override
  State<DrawerLoginInApp> createState() => _DrawerLoginInAppState();
}

class _DrawerLoginInAppState extends State<DrawerLoginInApp> {
  @override
  void initState() {

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: sizeH(context)*0.6,
        child: Container(
          height: sizeH(context),
          width: sizeW(context)*0.6,
          decoration: BoxDecoration(
              gradient:LinearGradient(colors: [
                theme(context).primaryColor.withOpacity(0.6),
                theme(context).primaryColor,
                theme(context).primaryColor,
                theme(context).primaryColor,
                theme(context).primaryColor,
                theme(context).primaryColor.withOpacity(0.6),
              ], 
                begin: Alignment.bottomLeft,
                end: Alignment.topRight
              )
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(alignment: Alignment.topRight,
                  child: IconButton(onPressed:()=> Scaffold.of(context).closeDrawer(),
                    icon:Icon(Icons.close,color: theme(context).canvasColor,),
                    
                  )),
              ),
              sizeBoxH(sizeH(context)*0.04),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: sizeH(context)*0.05,horizontal: sizeW(context)*0.05),
                child: Text(
                  'Please register or login to continue'.tr(),
                  style: theme(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700,fontSize: sizeW(context)*0.04,color: theme(context).backgroundColor),
                  textAlign: TextAlign.center,
                  ),
              ),
              sizeBoxH(sizeH(context)*0.06),
              SizedBox(
                width: double.infinity,
                height: sizeH(context)*0.3,
                child: kWalkingLottie,
              ),
              sizeBoxH(sizeH(context)*0.08),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: sizeH(context)*0.01),
                child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(sizeW(context)*0.54, sizeH(context)*0.06),
                              backgroundColor: theme(context).backgroundColor ,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            onPressed: (){
                              Scaffold.of(context).closeDrawer();
                              context.navigation(context,const LoginScreen());
                              // BlocProvider.of<AuthBloc>(context).add(InitialAuthEvent());
                            } , 
                            child: Text(
                              'Login'.tr() ,
                              style: theme(context).textTheme.titleSmall!.copyWith(
                                color: theme(context).focusColor,
                                fontSize: sizeW(context)*0.03
                              ),
                              )),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: sizeH(context)*0.01),
                child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(sizeW(context)*0.54, sizeH(context)*0.06),
                              backgroundColor:theme(context).focusColor.withOpacity(0.8) ,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            onPressed: (){
                              Scaffold.of(context).closeDrawer();
                              context.navigation(context,const SignupScreen());
                              // BlocProvider.of<AuthBloc>(context).add(InitialAuthEvent());
                            } , 
                            child: Text(
                               'signUp'.tr(),
                              style: theme(context).textTheme.titleSmall!.copyWith(
                                color:  theme(context).backgroundColor,
                                fontSize: sizeW(context)*0.03
                              ),
                              )),
              )
    
              // navigateButton(true),
              // navigateButton(false),
            ],
          ),
        ),
      ),
    );
  }
  // Widget navigateButton(bool isLoginScreen)=> Padding(
  //   padding:  EdgeInsets.symmetric(vertical: sizeH(context)*0.01),
  //   child: ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 minimumSize: Size(sizeW(context)*0.54, sizeH(context)*0.06),
  //                 backgroundColor:isLoginScreen ? theme(context).backgroundColor : theme(context).focusColor.withOpacity(0.8) ,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10)
  //                 )
  //               ),
  //               onPressed: ()=>isLoginScreen ?  context.beamToNamed('/auth',data: true) : context.beamToNamed('/auth',data: false), 
  //               child: Text(
  //                 isLoginScreen ? 'Login'.tr() : 'signUp'.tr(),
  //                 style: theme(context).textTheme.titleSmall!.copyWith(
  //                   color: isLoginScreen ? theme(context).focusColor : theme(context).backgroundColor,
  //                   fontSize: sizeW(context)*0.03
  //                 ),
  //                 )),
  // );

}