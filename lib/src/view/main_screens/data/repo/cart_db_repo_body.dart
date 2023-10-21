import 'package:project3/src/view/main_screens/data/data_source/local/init_hive_db.dart';
import 'package:project3/src/view/main_screens/domain/entities/cart_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/cart_db_repo_header.dart';

import '../model/local/cart_db_model.dart';

class CartDBRepoBody implements CartDBRepoHeader {
  
  @override
  Future addToBox(CartDBEntity data) async {
    final table = CartDBModel.fromCartDBEntity(data);
    return await boxList[0].put(table.id, table);
  }

  @override
  Future<List<CartDBEntity>> readFromBox() async {
    List<CartDBEntity> tableData =
        boxList[0].values.toList() as List<CartDBEntity>;
        
    return tableData;
  }

  @override
  Future updateFromBox(CartDBEntity data) async =>
      await boxList[0].putAt(data.id, data);

  @override
  Future deleteFromBox(int index) async => await boxList[0].deleteAt(index);

  @override
  Future clearBox() async => await boxList[0].clear();
}
