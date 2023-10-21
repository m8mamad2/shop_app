// ignore_for_file: use_build_context_synchronously, library_prefixes

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/screen/user_info_screen.dart';
import 'package:project3/src/view/onboadfing_screens/screen/onboarding_screen.dart';
import '../../core/animation/svgator/splash_screen.dart' as SVGator show SplashScreenSVGator, SplashScreenSVGatorState;
import '../../core/common/tasks/tasks.dart';
import '../../core/common/global_state/repo/repo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<SVGator.SplashScreenSVGatorState> SVGatorPlayer = GlobalKey<SVGator.SplashScreenSVGatorState>();
  bool checkConnection = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 15), () async {

    Future<bool> isFirst = Tasks.isFirstTime();
      

      isFirst.then((value) => value == true
        ?context.navigatiomRemove(context,const BottomNavigateWidget(selected: 0),)
        :context.navigatiomRemove(context,const OnBoardingScreens(),));
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();


    //! check Connection to Internet
    await InternetConnectionChecker().hasConnection
      .then((value) {

        if(value == true){
          
          setState(() => checkConnection = true);

          //! cache data 
          GlobalRepo repo = GlobalRepo(context: context);
          repo.save().then((value) {print(' ---------------- >Then GlobalRepo');});

          //! call api for homescreen
          context.read<ProductsBloc>().add(ApiCallProductsEvent(endPoint: 'products'));
        }
        else {
          setState(() => checkConnection = false,);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW(context),
      height: sizeH(context),
      color: theme(context).primaryColor,
      child: Stack(
        children: [
          Center(
            child: SVGator.SplashScreenSVGator(
              width: sizeW(context),
              height: sizeH(context),
              key: SVGatorPlayer,
            ),
          ),
         
          Padding(padding: EdgeInsets.symmetric(vertical: sizeH(context)*0.1),
          child:checkConnection == true  
           
            ? const Align(alignment: Alignment.bottomCenter,child: CircularProgressIndicator(color: Colors.white,))
            
            : Align(alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('No Internet',style: theme(context).textTheme.titleSmall,),
                  Material(
                    color: theme(context).primaryColor,
                    child: IconButton(
                      onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>super.widget ,)), 
                      icon: const Icon(Icons.replay_outlined)),
                  )
                ],
              )),
             
          )
          
        ],
      ),
    );
  }

}
