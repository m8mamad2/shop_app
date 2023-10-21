
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/images.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/constans/texts.dart';
import 'package:project3/src/core/common/constans/icons.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/bloc/auth_bloc.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/screen/login_screen.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/backend_db_bloc/backend_db_bloc.dart';

import '../../../../core/common/global_state/repo/repo.dart';
import '../../../main_screens/presentation/screen/home_screen.dart';
import '../widget/auth_textfield_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key,});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool isVisible = true;
  bool isLoginScreen = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

@override
void initState() {
  super.initState();
  // BlocProvider.of<AuthBloc>(context).add(InitialAuthEvent());
}
    

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: UniqueKey(),
        backgroundColor: theme(context).backgroundColor,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            state is LoadingAuthState 
                ? LoadingDialogs.show(context)
                : LoadingDialogs.hide(context);
          },
          
          builder: (context, state) {
            print('-======== Sign up Check $state ========');
            if (state is SuccessAuthState || state is LoadingAuthState) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    //! appbar
                    Container(
                      width: double.infinity,
                      height: sizeH(context) * 0.35,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(colors: [
                        theme(context).primaryColor.withOpacity(0.4),
                        theme(context).primaryColor,
                        theme(context).primaryColor,
                      ], radius: 1.3, center: const Alignment(0.5, -0.5))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: sizeW(context)*0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               
                               isEnglish(context) 
                                ? Image.asset( kLogo, width: sizeW(context) * 0.15, height: sizeH(context) * 0.08,) 

                                : IconButton(
                                  onPressed: () => context.navigation(context, const BottomNavigateWidget()),
                                  icon: Icon(isEnglish(context) ? Icons.arrow_forward :Icons.arrow_back,color: theme(context).backgroundColor,),),
                                  
                                isEnglish(context)
                                ?IconButton(
                                  onPressed: () => context.navigation(context, const BottomNavigateWidget()),
                                  icon: Icon(isEnglish(context) ? Icons.arrow_forward :Icons.arrow_back,color: theme(context).backgroundColor),)

                                :Image.asset(kLogo,width: sizeW(context) * 0.15,height: sizeH(context) * 0.08,)
                          
                              ],
                            ),
                          ),
                          sizeBoxH(sizeH(context)*0.07),
                          Text(
                            kAuthMainTitle.tr(),
                            style: theme(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontSize:isEnglish(context)?sizeW(context)*0.12: sizeW(context)*0.07,
                                    fontWeight: FontWeight.bold   ,
                                    color: Colors.white,
                                    ),
                          )
                        ],
                      ),
                    ),

                    //!shadow
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: sizeH(context) * 0.284),
                        width: sizeW(context) * 0.91,
                        height: sizeH(context) * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white54,
                        ),
                      ),
                    ),

                    //!forms
                    Container(
                      margin: EdgeInsets.only(top: sizeH(context) * 0.3),
                      width: double.infinity,
                      height: sizeH(context) * 0.65,
                      padding: EdgeInsets.only(top: sizeH(context)*0.03),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          )),
                      child: Form(
                        key: key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:isEnglish(context) ? sizeH(context) * 0.048 :sizeH(context) * 0.04),
                              child: Text(
                                kAuthSignupTitle.tr(),
                                style: theme(context).textTheme.titleSmall!
                                    .copyWith(fontSize: sizeW(context)*0.06,fontWeight: FontWeight.w900,color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical:isEnglish(context)? sizeH(context) * 0.025:sizeH(context)*0.01),
                              child: Text(
                                kAuthSignUpSubtitle.tr(),
                                style: theme(context).textTheme.titleSmall!
                                    .copyWith(color: Colors.black54,fontWeight: FontWeight.w400),
                              ),
                            ),
                            isEnglish(context)?const SizedBox.shrink() : sizeBoxH(sizeH(context)*0.025),
                            authTextFormWidget(context, email, kAuthEmail.tr(), null, null, isVisible, false, null,),
                            authTextFormWidget(
                              context,
                              password,
                              kAuthPassword.tr(),
                              kVisibleFalseAuthIcon,
                              kVisibleAuthIcon,
                              isVisible,
                              true,
                              () => setState(() => isVisible = !isVisible),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: sizeH(context) * 0.02),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if(key.currentState!.validate()) BlocProvider.of<AuthBloc>(context).add(SignUpAuthEvent( context: context, email: email.text, password:password.text.toString()));
                                    
                                  
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:theme(context).primaryColor,
                                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                                    minimumSize: Size(sizeW(context) * 0.9,sizeH(context) * 0.073)),
                                child: Text(
                                  kAuthSignup.tr(),
                                  style: theme(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontSize:isEnglish(context) ? sizeW(context)*0.037:sizeW(context)*0.027,color: Colors.white),
                                ),
                              ),
                            ),
                            // widget.isLoginScreen
                            //     ? TextButton(
                            //         onPressed: () =>context.beamToNamed('/forgotPassword'),
                            //         child: Text(
                            //           kAuthForgotPassword.tr(),
                            //           style: theme(context)
                            //               .textTheme
                            //               .titleMedium!
                            //               .copyWith(
                            //                   fontSize:isEnglish(context) ? sizeW(context)*0.04 : sizeW(context)*0.035,
                            //                   color: Colors.black54,
                            //                   fontWeight: FontWeight.w600),
                            //         ))
                            //     : Container(),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    kAuthSignUPFoother.tr(),
                                    style: theme(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: sizeW(context)*0.028),
                                  ),
                                  sizeBoxW(5),
                                  InkWell(
                                    onTap:() {
                                      // BlocProvider.of<AuthBloc>(context).add(InitialAuthEvent());
                                      context.navigation(context,const LoginScreen());
                                      },
                                    child: Text(
                                      kAuthLogin.tr(),
                                      style: theme(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: sizeW(context)*0.035,
                                              fontFamily: 'header',
                                              color: theme(context).primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            if (state is FailAuthState) return Text(state.error.toString());
            return Container(
                color: Colors.amber,
                width: 300,
                height: 300,
                child: Center(child: Text(state.toString())));
          },
        ),
      ),
    );
  }
}
