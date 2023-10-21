part of 'contact_db_bloc.dart';

@immutable
abstract class ContactDbState {}

class InitialContactDBState extends ContactDbState {}

class LoadingContactDBState extends ContactDbState {}

class SuccessContactDBState extends ContactDbState {
  final List<ContactDBEntity> data;
  SuccessContactDBState({required this.data});
}

class FailContactDBState extends ContactDbState {
  final String error;
  FailContactDBState(this.error);
}
