part of 'cart_db_bloc.dart';

@immutable
abstract class CartDbState {}

class InitialCartDBState extends CartDbState {}

class LoadingCartDBState extends CartDbState {}

class SuccessCartDBState extends CartDbState {
  List<CartDBEntity> data;
  SuccessCartDBState({required this.data});
}

class FailCartDBState extends CartDbState {
  final String? error;
  FailCartDBState({this.error});
}
