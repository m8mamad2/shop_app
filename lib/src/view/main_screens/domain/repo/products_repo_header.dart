import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';

abstract class ProductsRepoHeader {
  Future<List<ProductsEntity>> result(String endPoint);
}
