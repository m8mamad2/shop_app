part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}


class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {
  final bool isUserLoggedIn;
  final String currentUser;

  SuccessAuthState({required this.isUserLoggedIn,required this.currentUser});
}

class FailAuthState extends AuthState {
  final String? error;
  FailAuthState({this.error});
}
