import 'package:project3/src/view/main_screens/domain/entities/favorite_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/favorite_db_repo_header.dart';

import '../data_source/local/init_hive_db.dart';
import '../model/local/favorite_db_model.dart';

class FavoriteDBRepoBody implements FavoriteDBRepoHeader {
  @override
  Future addToBox(FavoriteDBEntity favoriteDBEntity) async {
    final table = FavoriteDBModel.fromFavoriteDBEntity(favoriteDBEntity);
    return await boxList[1].put(table.id, table);
  }

  @override
  Future<List<FavoriteDBEntity>> getFromBox() async {
    List<FavoriteDBEntity> data =boxList[1].values.toList() as List<FavoriteDBEntity>;
    return data;
  }

  @override
  Future deleteFromBox(int index) async => await boxList[1].delete(index);

  @override
  Future clearBox() async => await boxList[1].clear();
}
