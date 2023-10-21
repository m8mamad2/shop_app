import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/view/main_screens/presentation/screen/cart_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/category_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/chat_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/contact/contacts_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/favorite_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/home_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/report_error_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/search_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/user_info_screen.dart';
import 'package:project3/src/view/main_screens/presentation/widget/drawer_widget/drawe_rating_widget.dart';
import 'package:project3/src/view/main_screens/presentation/widget/profile_widget/profile_check.dart';

//! bottom navigation bar
List<Widget> kBottomNavigationWidgts = [
  const HomeScreen(),
  const CategoryScreen(),
  CartScreen(isBottomNavbar: true),
  SearchScreen(inBottonNavbar: true),
  const ProfileCheckIsLogged(),
];

List<BottomNavigationBarItem> kBottomNavigationBarItem = [
  BottomNavigationBarItem(label:'Home'.tr() ,icon:const Icon(Icons.home)),
  BottomNavigationBarItem(label:'Category'.tr() ,icon:const Icon(Icons.grid_view_rounded)),
  BottomNavigationBarItem(label:'Cart'.tr() ,icon:const Icon(Icons.shopping_cart)),
  BottomNavigationBarItem(label:'Search'.tr() ,icon:const Icon(Icons.search)),
  BottomNavigationBarItem(label:'Profile'.tr() ,icon:const Icon(Icons.person)),
];

//!drawe
List<Widget> kDrawerWidgets = [
  const UserInfoScreen(onPress: BottomNavigateWidget(selected: 0,)),
  SearchScreen(inBottonNavbar: false),
  const FavoriteScreen(widget: BottomNavigateWidget(selected: 0,)),
  // ChatScreen(name: 'Ali'),
  const ContactsScreen(),
  const ReportErrorScreen(),
  DrawerRatingWidget()// for rating
];

//! contacts
const List<TextInputType> kContactsInputType = [
  TextInputType.text,
  TextInputType.emailAddress,
  TextInputType.number,
  TextInputType.number,
];


final List<TextEditingController> contactsControllers = [name,email,age,number,];
final TextEditingController name = TextEditingController();
final TextEditingController email = TextEditingController();
final TextEditingController age = TextEditingController();
final TextEditingController number = TextEditingController();
final TextEditingController collegeEducation = TextEditingController();
final TextEditingController highSchoolEducation = TextEditingController();

const List<int> kContactsMaxLenght = [100,100,3,12];

List<TextInputType> kUserInfoInputType = [
  TextInputType.text,
  TextInputType.text,
  TextInputType.text,
  TextInputType.phone,
  TextInputType.phone,
];