import 'package:project3/src/view/main_screens/domain/entities/favorite_db_entity.dart';

abstract class FavoriteDBRepoHeader {
  Future addToBox(FavoriteDBEntity favoriteDBEntity);
  Future<List<FavoriteDBEntity>> getFromBox();
  Future deleteFromBox(int index);
  Future clearBox();
}
