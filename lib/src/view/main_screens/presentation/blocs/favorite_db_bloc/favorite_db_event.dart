part of 'favorite_db_bloc.dart';

@immutable
abstract class FavoriteDbEvent {}

class InitialFavoriteDBEvent extends FavoriteDbEvent {}

class AddToFavoriteDBEvent extends InitialFavoriteDBEvent {
  final FavoriteDBEntity favoriteDBEntity;
  AddToFavoriteDBEvent({required this.favoriteDBEntity});
}

class DeleteFromFavoriteDBEvent extends InitialFavoriteDBEvent {
  final int index;
  DeleteFromFavoriteDBEvent({required this.index});
}

class ClearFavoriteDBEvent extends InitialFavoriteDBEvent {}
