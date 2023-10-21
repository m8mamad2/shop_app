import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';
import 'package:uuid/uuid.dart';

part 'contact_db_model.g.dart';

@HiveType(typeId: 3)
class ConcatsDBModel extends ContactDBEntity{

  @HiveField(0)
  final String? name;
  
  @HiveField(1)
  final String? email;
  
  @HiveField(2)
  final String? collegeEducation;

  @HiveField(3)
  final String? highSchoolEducation;
  
  @HiveField(4)
  final String? age;
  
  @HiveField(5)
  final String? number;
  
  @HiveField(6)
  final String? notes;

  @HiveField(7)
  String? id;

  @HiveField(8)
  final Uint8List? image;
  
  ConcatsDBModel(
     this.id,
     this.name,
     this.email,
     this.collegeEducation,
     this.highSchoolEducation,
     this.age,
     this.number,
     this.notes,
     this.image
    )
  :super(
        id: id,
        name:name,
        email:email,
        collegeEducation:collegeEducation,
        highSchoolEducation:highSchoolEducation,
        age:age,
        number:number,
        notes:notes,
        image: image);

  factory ConcatsDBModel.fromEntity(ContactDBEntity entity) =>ConcatsDBModel(
    entity.id,
    entity.name, 
    entity.email, 
    entity.collegeEducation, 
    entity.highSchoolEducation, 
    entity.age, 
    entity.number, 
    entity.notes,
    entity.image
    );
}    
