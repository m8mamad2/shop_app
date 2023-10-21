import 'package:project3/src/view/main_screens/domain/repo/cart_db_repo_header.dart';

import '../entities/cart_db_entity.dart';

class CartDBUseCase {
  final CartDBRepoHeader repo;
  CartDBUseCase(this.repo);

  Future addToBox(CartDBEntity data) async => await repo.addToBox(data);
  Future<List<CartDBEntity>> readFromBox() async => await repo.readFromBox();
  Future deleteFromBox(int index) async => await repo.deleteFromBox(index);
  Future clearBox() async => await repo.clearBox();
  Future updateFromBox(CartDBEntity data) async =>
      await repo.updateFromBox(data);
}
