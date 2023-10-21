import 'package:flutter/material.dart';

abstract class AuthHelperHead {
  Future signUpInUI(BuildContext context, String email, String password);
  Future loginInUI(BuildContext context, String email, String password);
  Future logOutInUI(BuildContext context);
  Future<bool> isUserLoggedInUI();
  Future<String> curretnUserInUI();
}
