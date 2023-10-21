// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:project3/src/view/authenticaton_screen/domain/repo/auth_helper_head.dart';
import 'package:project3/src/core/common/global_state/repo/repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthHelperHead authUseCase;

  AuthBloc(this.authUseCase) : super((LoadingAuthState())) {

    on<SignUpAuthEvent>((event, emit) async {
      emit(LoadingAuthState());

      bool isUserLogged =await authUseCase.isUserLoggedInUI();
      String currentUser =await authUseCase.curretnUserInUI();


      try {
        
        await authUseCase.signUpInUI(event.context, event.email, event.password);

        emit(SuccessAuthState(isUserLoggedIn: isUserLogged,currentUser: currentUser));
      } 
      catch (err) { emit(FailAuthState(error: err.toString())); }
    });
    on<LogInAuthEvent>((event, emit) async {
      emit(LoadingAuthState());

      bool isUserLogged =await authUseCase.isUserLoggedInUI();
      String currentUser =await authUseCase.curretnUserInUI();

      try {
        
        await authUseCase.loginInUI(event.context, event.email, event.password);

        emit(SuccessAuthState(isUserLoggedIn: isUserLogged,currentUser: currentUser));
      } 
      catch (err) { emit(FailAuthState(error: err.toString())); }
    });
    on<LogOutAuthEvent>((event, emit) async {
      emit(LoadingAuthState());

      bool isUserLogged =await authUseCase.isUserLoggedInUI();
      String currentUser =await authUseCase.curretnUserInUI();


      try {
        
        await authUseCase.logOutInUI(event.context);

        emit(SuccessAuthState(isUserLoggedIn: isUserLogged,currentUser: currentUser));
      } 
      catch (err) { emit(FailAuthState(error: err.toString())); }
    });
    // on<>
  }
}

