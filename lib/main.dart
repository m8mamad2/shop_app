
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project3/locator.dart';
import 'package:project3/src/config/localization/localization_config.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/multi_bloc_provider.dart';
import 'package:project3/src/core/widget/error_bloc.dart';
import 'package:project3/src/view/main_screens/data/data_source/local/init_hive_db.dart';
import 'package:project3/src/view/onboadfing_screens/screen/onboarding_screen.dart';
import 'package:project3/src/view/splash_screen/splash_screen.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();


  HydratedBloc.storage =
   await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());


  //*localizatino
  await EasyLocalization.ensureInitialized();
  
  //*hive
  await openBoxes();
  
  //*get_it
  await getItSetup();


  //* notification
 runApp(EasyLocalozationConfig(MultiBlocProviderConfig(const MyApp())));


  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context,listen: true);
    return MaterialApp(
      
        // * localization
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        //* theme
        theme: theme.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        themeMode: ThemeMode.system,
        
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),

        themeAnimationCurve: Curves.linear,
      );}
}


