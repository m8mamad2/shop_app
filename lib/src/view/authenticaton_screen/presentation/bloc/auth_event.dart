part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

// class InitialAuthEvent extends AuthEvent {}

class SignUpAuthEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;
  SignUpAuthEvent(
      {required this.context, required this.email, required this.password});
}

class LogInAuthEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;
  LogInAuthEvent(
      {required this.context, required this.email, required this.password});
}

class LogOutAuthEvent extends AuthEvent {
  final BuildContext context;
  LogOutAuthEvent({
    required this.context,
  });
}
