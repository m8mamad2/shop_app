import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/cart_db_bloc/cart_db_bloc.dart';

class CartDBEntity {
  final int id;
  final String title;
  final num price;
  final String image;
  int houmuch;
  dynamic color;
  dynamic size;

  CartDBEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.houmuch,
    required this.color,
    required this.size,
  });

  // static List<CartDBEntity> fromCartDBModel(CartDBModel model) {
  //   List<CartDBEntity> list = [];
  //   return list
  //       .map((e) => CartDBEntity(
  //           id: model.id,
  //           title: model.title,
  //           price: model.price,
  //           image: model.image,
  //           houmuch: model.houmuch,
  //           color: model.color,
  //           size: model.size))
  //       .toList();
  // }

  factory CartDBEntity.fromProductsEntity(ProductsEntity productsEntity) {
    return CartDBEntity(
        id: productsEntity.id!,
        title: productsEntity.title!,
        price: productsEntity.price!,
        image: productsEntity.image!,
        houmuch: productsEntity.howmuch,
        color: productsEntity.color!,
        size: productsEntity.size!);
  }
}
