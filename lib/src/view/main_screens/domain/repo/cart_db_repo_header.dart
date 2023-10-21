import 'package:project3/src/view/main_screens/domain/entities/cart_db_entity.dart';

abstract class CartDBRepoHeader {
  Future addToBox(CartDBEntity data);
  Future<List<CartDBEntity>> readFromBox();
  Future updateFromBox(CartDBEntity data);
  Future deleteFromBox(int index);
  Future clearBox();
}
