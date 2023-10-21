import 'package:flutter/material.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/main_screens/presentation/screen/chat_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/favorite_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/user_info_screen.dart';
import 'package:project3/src/view/main_screens/presentation/widget/profile_widget/profile_change_language_widget.dart';

import '../../../../../core/widget/bottom_navigatebar_widget.dart';


class ProfileScreenOnTaps{

  static VoidCallback onTaps(BuildContext context,int index,String name,){

    switch(index){
      case 0 : return () =>context.navigation(context, const FavoriteScreen(widget: BottomNavigateWidget(selected: 4),));
      // case 1 : return () =>null;//context.navigation(context, ChatScreen(name: name));
      case 1 : return () =>context.navigation(context, const UserInfoScreen(onPress:  BottomNavigateWidget(selected: 4,),));//context.beamToNamed('/info'); 
      case 2 : return () => showDialog(context: context,builder: (context) => const ProfileChangeLanguageWidget()); 
      default: return (){};
    }
}
}
