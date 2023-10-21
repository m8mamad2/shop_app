import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/products_repo_header.dart';

class ProductsUseCase {
  final ProductsRepoHeader repo;
  ProductsUseCase(this.repo);

  Future<List<ProductsEntity>> result(String endPoint) => repo.result(endPoint);
}
