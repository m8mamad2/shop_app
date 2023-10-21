// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/core/widget/dialogs.dart';
import 'package:project3/src/view/authenticaton_screen/domain/repo/auth_helper_head.dart';
import 'package:project3/src/view/authenticaton_screen/domain/repo/auth_repo_head.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/screen/login_screen.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/screen/signup_screen.dart';
import 'package:project3/src/core/common/global_state/repo/repo.dart';


class AuthHelperBody extends AuthHelperHead {
  AuthRepoHead repo;
  AuthHelperBody(this.repo);

  @override
  Future signUpInUI(BuildContext context, String email, String password) async {
    return await repo.signUp(email, password.toString()).then((value)async {
       if(value =='OK'){
        print('=========> signup Success');
        GlobalRepo repo = GlobalRepo(context: context);
        await repo.saveForSignup();
        return await  context.navigatiomRemove(context, const BottomNavigateWidget());
        
      }
      else{
        return await showDialog(context: context, builder: (context) => 
          inUIDialogs(context, value,'Signup was not successful',value == 'OK',() => context.navigatiomRemove(context, const SignupScreen()),),);
      }
    });
  }

  @override
  Future loginInUI(BuildContext context, String email, String password) async {
    return repo.logIn(email, password.toString())
    .then((value) async{
      
      if(value =='OK'){
        GlobalRepo repo = GlobalRepo(context: context);
        await repo.save();
        return await context.navigatiomRemove(context, const BottomNavigateWidget());
      }
      else{
        return await showDialog(context: context, builder: (context) => inUIDialogs(context, value,'Login to account was not successful',value == 'OK',() => context.navigatiomRemove(context, const LoginScreen()),),);
      }

    });
  }

  @override
  Future<dynamic> logOutInUI(BuildContext context)async {
    return await repo.logOut()
      .then((value) async {
        bool isSuccess = value == 'OK' ? true : false;
        if(isSuccess) { return Scaffold.of(context).closeDrawer(); }
        
        else{
          Scaffold.of(context).closeDrawer();
          return await showDialog(context: context, builder: (context) => inUIDialogs(context, value, 'Logging out was successful' ,isSuccess, () =>context.navigation(context, const BottomNavigateWidget(selected: 0,))),);
        }
          
      });
  }

  @override
  Future<bool> isUserLoggedInUI() => repo.isUserLoggedIn();

  @override
  Future<String> curretnUserInUI() => repo.curretnUser();
}
