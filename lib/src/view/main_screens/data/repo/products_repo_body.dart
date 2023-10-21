import 'package:dio/dio.dart';
import 'package:project3/src/view/main_screens/data/data_source/remote/remote_data.dart';
import 'package:project3/src/view/main_screens/data/model/product_model.dart';
import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/products_repo_header.dart';

class ProductsRepoBody implements ProductsRepoHeader {
  ApiProvider apiProvider;
  ProductsRepoBody(this.apiProvider);

  Future<List<ProductsEntity>> result(String endPoint) async {
    Response response = await apiProvider.callApi(endPoint);
    try {
      if (response.statusCode == 200) {
        final List<ProductsEntity> result = (response.data as List)
            .map((e) => ProductsModel.fromJson(e))
            .toList();

        return result;
      } else {
        return [];
      }
    } catch (e) {
      print('--->>>---->> $e');
      return [];
    }
  }
}
