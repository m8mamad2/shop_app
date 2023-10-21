import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveChangeTheme{

 static Future<bool> isDarkTheme()async{
    final SharedPreferences prf =await SharedPreferences.getInstance();
    bool? a = prf.getBool('isDark');
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ $a');
    return a ?? false;
 }
}