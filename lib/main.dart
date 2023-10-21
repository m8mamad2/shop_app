
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




// ! flat list
// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});
//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }
// class _MyWidgetState extends State<MyWidget> {
//   List a = List.generate(20, (index) => 'index $index');
//   final ScrollController controller = ScrollController();
//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(() { 
//       if(controller.position.maxScrollExtent == controller.offset){fetch();}
//     });
//   }
//   Future fetch()async{
//     setState(() {
//       a.addAll(['A','B','C']);
//     });
//   }
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView.builder(
//         controller: controller,
//         itemCount: a.length + 1,
//         itemBuilder:(context,index) {
//           if(index < a.length){
//             final item = a[index];
//             return ListTile(title: Text(item),);
//           }
//           else{
//             return Padding(
//               padding: EdgeInsets.all(32),
//               child: SizedBox(
//                 width: 200 ,
//                 child: CircularProgressIndicator()),
//               );
//           }
//         }),
//     );
//   }
// }

//! hydrate bloc
// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});
//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }
// class _MyWidgetState extends State<MyWidget> {
//   // Future a()async{
//   //   print('AAAAa');
//   //   AuthRepoBody repo = AuthRepoBody();
//   //   bool isLoggin =await repo.isUserLoggedIn();
//   //   final A.Storage storage = A.Storage(BackendInitial.instance.client);
//   //   final A.Databases databases = A.Databases(BackendInitial.instance.client);
//   //   final A.Account account = A.Account(BackendInitial.instance.client);
//   //   BackendDBRepoBody repoBody = BackendDBRepoBody(repo, storage, databases, account);
//   //   final Uint8List image = await repoBody.getUserPicture();
//   //   final Map userInfo = await repoBody.getUserInfoData();
//   //   final String name = userInfo['name'];
//   //   HydrateModel model = HydrateModel(isLoggin: isLoggin,image: image,name: name);
//   //   print('isLoggin $isLoggin , iamge $image , name $name',);
//   //   // ignore: use_build_context_synchronously
//   //   context.read<HydrateBLocBloc>().add(SaveDataHydrateEvent(model: model));
//   //   print('BBBBBb');
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // ElevatedButton(onPressed: ()=> a(), child: Text('get')),
//             ElevatedButton(onPressed: ()=>context.navigation(context, MyWidget1()), child: Text('go')),
//             ElevatedButton(onPressed: ()=>setState(() {print('setState');}), child: Text('setState')),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class MyWidget1 extends StatefulWidget {
//   const MyWidget1({super.key});
//   @override
//   State<MyWidget1> createState() => _MyWidget1State();
// }
// class _MyWidget1State extends State<MyWidget1> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GlobalBloc,GlobalModel>(
//               builder: (context, state) {
//                   bool? isLoggin = state.isLoggin;
//                   print(state.image );
//                   print(state.isLoggin );
//                   print(state.name );
//                 return isLoggin != null && isLoggin == true
//                     ? A1() 
//                     : B();               
//               },
//             );
//   }
// }
// class A1 extends StatelessWidget {
//   const A1({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amber,    
//     );
//   }
// }
// class B extends StatelessWidget {
//   const B({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.red,
//     );
//   }
// }
