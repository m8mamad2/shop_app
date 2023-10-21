// ignore_for_file: non_constant_identifier_names

import 'package:project3/src/view/main_screens/domain/entities/favorite_db_entity.dart';

class ProductsEntity {
  final int? id;
  final String? title;
  final num? price;
  final String? description;
  final String? IRdescription;
  final String? image;
  int howmuch;
  String? color;
  List? colors;
  List<int>? size;

  ProductsEntity(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.IRdescription,
      this.image,
      required this.howmuch,
      this.color,
      this.colors,
      this.size});

}
