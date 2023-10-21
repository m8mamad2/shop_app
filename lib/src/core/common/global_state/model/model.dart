import 'dart:typed_data';

class GlobalModel {
  final bool? isLoggin;
  final String? name;
  final Uint8List? image;

  GlobalModel({this.isLoggin,this.name,this.image});



  factory GlobalModel.fromJson(Map<String,dynamic> json)=> GlobalModel(
    image: json['image'],
    name: json['name'],
    isLoggin: json['isLoggin']
  );


  Map<String,dynamic> toJson(){
      final map = <String ,dynamic>{};
      map['name']=name;
      map['image']=image;
      map['isLoggin']=isLoggin;
      return map;
    }
    
}