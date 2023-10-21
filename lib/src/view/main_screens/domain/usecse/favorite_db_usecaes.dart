import 'package:project3/src/view/main_screens/domain/entities/favorite_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/favorite_db_repo_header.dart';

class FavoriteDBUseCase {
  final FavoriteDBRepoHeader repo;
  FavoriteDBUseCase(this.repo);

  Future addToBox(FavoriteDBEntity entity)async =>await repo.addToBox(entity);
  Future<List<FavoriteDBEntity>> getFromBox()async =>await repo.getFromBox();
  Future deleteFromBox(int index) async => await repo.deleteFromBox(index);
  Future clearBox() async => await repo.clearBox();
}

