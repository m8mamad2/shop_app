import 'package:project3/src/view/main_screens/domain/entities/backend_db_entity.dart';

class BackendDBModel extends BackendDBEntity{
  
  BackendDBModel(
    {String? id,
    String? email,
    String? name,
    String? family,
    String? address,
    String? phoneNumber,    
    String? homeNumber,
    // List<int>? image
    }
  ):super(
    id:id,
    email:email,
    name:name,
    family:family,
    address:address,
    phoneNumber:phoneNumber,
    homeNumber:homeNumber,
    // image:image
  );

  factory BackendDBModel.fromJson(Map<String,dynamic> json) =>BackendDBModel(
    id :json['id '],
    email :json['email '],
    name :json['name '],
    family :json['family '],
    address :json['address '],
    phoneNumber :json['phoneNumber '],
    homeNumber:json['homeNumber'],
    // image: json['image']
    );
    
  Map<String,dynamic> toJson(Map<String,dynamic> map){
    map['id'] =id ;
    map['email'] =email ;
    map['name'] =name ;
    map['family'] =family ;
    map['address'] =address ;
    map['phoneNumber'] =phoneNumber ;
    map['homeNumber']=homeNumber;
    // map['image'] =image;
    return map;
  }
  
  static Map<String,dynamic> toBackend(BackendDBEntity data,String user)=>{
    'id':user,
    // 'email':,
    'name':data.name,
    'family':data.family,
    'address':data.address,
    'phoneNumber':data.phoneNumber,
    'homeNumber':data.homeNumber,
    // 'image':data.image
  };

  static Map<String,dynamic> forSignUp(String id)=> {
    'id':id,
    'email':null,
    'name':null,
    'family':null,
    'address':null,
    'phoneNumber':null,
    'homeNumber':null,
  };
}