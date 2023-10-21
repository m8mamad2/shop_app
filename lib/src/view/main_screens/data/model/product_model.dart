import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';

class ProductsModel extends ProductsEntity {
  ProductsModel({
    int? id,
    String? title,
    num? price,
    String? description,
    String? IRdescription,
    String? image,
    int howmuch = 1,
    String? color,
    List? colors,
    List<int>? size,
  }) : super(
            id: id,
            title: title,
            price: price,
            description: description,
            IRdescription: IRdescription,
            image: image,
            howmuch: howmuch,
            color: color,
            colors: colors,
            size: size);

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json['id'],
        title: json['title'],
        price: int.parse((json['price']).toString()),
        description: json['description'],
        IRdescription: json['IRdescription'],
        image: json['image'],
        howmuch: json['howmuch'],
        color: json['color'].toString(),
        colors: List.from(json['colors'].map((x) => x)),
        size: List<int>.from(json['size'].map((x) => x)),
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['description'] = description;
    map['IRdescription'] = IRdescription;
    map['image'] = image;
    map['howmuch'] = howmuch;
    map['color'] = color;
    map['colors'] = colors;
    map['size'] = size;
    return map;
  }
}
