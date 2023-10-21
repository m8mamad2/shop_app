import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/widget/drawer.dart';
import 'package:project3/src/core/widget/offline_screen.dart';
import 'package:project3/src/core/common/global_state/repo/repo.dart';

import '../common/constans/widgets.dart';


class BottomNavigateWidget extends StatefulWidget {
  final int? selected;
  const BottomNavigateWidget({super.key,this.selected});
  

  @override
  State<BottomNavigateWidget> createState() =>_BottomNavigateWidgetState();
}

class _BottomNavigateWidgetState extends State<BottomNavigateWidget> {

  late int _selected;
  
  @override
  void initState() {
    super.initState();
    _selected = widget.selected ?? 0;
  }

  @override
  Widget build(BuildContext context) =>
    StreamBuilder<InternetConnectionStatus>(
      stream: InternetConnectionChecker().onStatusChange,
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:return mainWidget();
          default:
            if(snapshot.data == InternetConnectionStatus.connected){
              GlobalRepo repo = GlobalRepo(context: context);
              repo.save();
              return mainWidget();
            }
            else {return const OfflineScreen();}
        }
      },);
      
       
  //* scaffold and navigaton bar widget
  Widget mainWidget()=> Scaffold(
        drawer:const DrawerWidget(),
        body: Stack(
          children: [
            Center(child: kBottomNavigationWidgts.elementAt(_selected),),
            Align(
              alignment: Alignment.bottomCenter,
              child: bottomNavigationBar()),
        ],),);

  //* bottom navigation bar widget
  Widget bottomNavigationBar() {

    Color iconColor= BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).focusColor : theme(context).backgroundColor;

    TextStyle textTheme = theme(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold,
      fontSize: sizeW(context)*0.03,
      color: BlocProvider.of<ThemeCubit>(context).isDark 
        ?theme(context).focusColor
        :theme(context).backgroundColor);
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: theme(context).canvasColor,
              boxShadow:  const[
                BoxShadow(
                    blurRadius: 6,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 0,
                    offset: Offset(-1, 6),
                    color: Colors.black26)
              ]),
          child: GNav(
              gap: 15,
              activeColor: iconColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 13),
              tabBackgroundColor: theme(context).primaryColor,
              color: theme(context).focusColor.withOpacity(0.8),
              tabBorderRadius: 20,
              curve: Curves.decelerate,
              selectedIndex: _selected,
              tabMargin: const EdgeInsets.symmetric(vertical: 9),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              onTabChange: (value) {
                if (!mounted) return;
                setState(() => _selected = value);
              },
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home'.tr(),
                  textStyle: textTheme,
                ),
                GButton(
                  icon: Icons.grid_view_rounded,
                  text: 'Category'.tr(),
                  textStyle: textTheme,
                ),
                GButton(
                  icon: Icons.shopping_cart,
                  text: 'Cart'.tr(),
                  textStyle: textTheme,
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search'.tr(),
                  textStyle: textTheme,
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile'.tr(),
                  textStyle: textTheme,
                ),
              ]),
        ),
      );}

}



