import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';

class FavoriteDBEntity {
  final int id;
  final String image;
  final String title;
  final num price;

  FavoriteDBEntity({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
  });

  factory FavoriteDBEntity.fromProductsEntity(ProductsEntity productsEntity)=>
    FavoriteDBEntity(
      id: productsEntity.id!, 
      image: productsEntity.image!, 
      title: productsEntity.title!, 
      price: productsEntity.price!);
}
