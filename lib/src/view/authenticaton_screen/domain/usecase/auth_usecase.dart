import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/view/authenticaton_screen/domain/repo/auth_helper_head.dart';

class AuthUseCase {
  AuthHelperHead authRepo;
  AuthUseCase({required this.authRepo});

  Future logIn(BuildContext context, String email, String password) =>authRepo.loginInUI(context, email, password);

  Future logOut(BuildContext context) => authRepo.logOutInUI(context);

  Future signUp(BuildContext context, String email, String password) =>authRepo.signUpInUI(context, email, password);

  Future<bool> isUserLoggedIn() => authRepo.isUserLoggedInUI();

  Future<String> curretnUser() => authRepo.curretnUserInUI();
}
