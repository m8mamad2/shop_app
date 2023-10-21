part of 'favorite_db_bloc.dart';

@immutable
abstract class FavoriteDbState {}

class InitialFavoriteDBState extends FavoriteDbState {}

class LoadingFavoriteDBState extends FavoriteDbState {}

class SuccessFavoriteDBState extends FavoriteDbState {
  List<FavoriteDBEntity> data;
  SuccessFavoriteDBState({required this.data});
}

class FailFavoriteDBState extends FavoriteDbState {
  final String? error;
  FailFavoriteDBState({this.error});
}
