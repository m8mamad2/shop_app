import 'package:hive/hive.dart';
import 'package:project3/src/view/main_screens/domain/entities/favorite_db_entity.dart';

part 'favorite_db_model.g.dart';

@HiveType(typeId: 2)
class FavoriteDBModel extends FavoriteDBEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final num price;

  FavoriteDBModel(
    this.id,
    this.title,
    this.image,
    this.price,
  ) : super(id: id, image: image, title: title, price: price);

  factory FavoriteDBModel.fromFavoriteDBEntity(FavoriteDBEntity entity) =>
      FavoriteDBModel(entity.id, entity.title, entity.image, entity.price);
}
