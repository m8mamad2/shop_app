part of 'cart_db_bloc.dart';

@immutable
abstract class CartDbEvent {}

class InitialCartDBEvent extends CartDbEvent {}

class AddToCartDBEvent extends InitialCartDBEvent {
  final CartDBEntity data;
  AddToCartDBEvent({required this.data});
}

// class ReadFromCartDBEvent extends InitialCartDBEvent{}

class UpdateFromCartDBEvent extends InitialCartDBEvent {
  final CartDBEntity data;
  UpdateFromCartDBEvent({required this.data});
}

class DeleteFromCartDBEvent extends InitialCartDBEvent {
  final int index;
  DeleteFromCartDBEvent({required this.index});
}

class ClearFromCartDBEvent extends InitialCartDBEvent {}
