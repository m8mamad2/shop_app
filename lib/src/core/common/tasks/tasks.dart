import 'package:shared_preferences/shared_preferences.dart';

class Tasks{

  static Future<bool> isFirstTime() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool? isFirstTime = preferences.getBool('if_First_Time');

      if (isFirstTime != null && isFirstTime) return true;
      else return false;

    }

  static Future<void> setFirstTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('if_First_Time', true);
  }

  

}