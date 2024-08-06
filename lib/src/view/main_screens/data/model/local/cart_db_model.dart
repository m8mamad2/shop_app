import 'package:project3/src/view/main_screens/domain/entities/cart_db_entity.dart';
import 'package:hive/hive.dart';
import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';

part 'cart_db_model.g.dart';

@HiveType(typeId: 1)
class CartDBModel extends CartDBEntity {
  @override
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title; 

  @HiveField(2)
  final num price;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final int howmuch;

  @HiveField(5)
  final dynamic color;

  @HiveField(6)
  final dynamic size;

  CartDBModel(
    this.id,
    this.title,
    this.price,
    this.image,
    this.howmuch,
    this.color,
    this.size,
  ) : super(
          id: id,
          title: title,
          price: price,
          image: image,
          houmuch: howmuch,
          color: color,
          size: size,
        );

  factory CartDBModel.fromCartDBEntity(CartDBEntity cartDBEntity) {
    return CartDBModel(
        cartDBEntity.id,
        cartDBEntity.title,
        cartDBEntity.price,
        cartDBEntity.image,
        cartDBEntity.houmuch,
        cartDBEntity.color,
        cartDBEntity.size);
  }
}
