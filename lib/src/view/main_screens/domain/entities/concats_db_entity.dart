import 'dart:typed_data';

import 'package:flutter/material.dart';

class ContactDBEntity{
  final String? id;
  final String? name;
  final String? email;
  final String? collegeEducation;
  final String? highSchoolEducation;
  final String? age;
  final String? number;
  final String? notes;
  final Uint8List? image;

  ContactDBEntity({
    this.id,
    this.name,
    this.email,
    this.collegeEducation,
    this.highSchoolEducation,
    this.age,
    this.number,
    this.notes,
    this.image
  });

  factory ContactDBEntity.fromControllers(
    List<TextEditingController> controllers,
    TextEditingController collegeEducation,
    TextEditingController highSchoolEducation,
    Uint8List? image,
    String? id,
    ) => ContactDBEntity(
    id: id,
    name: controllers[0].text,
    email: controllers[1].text,
    age: controllers[2].text,
    number: controllers[3].text,
    collegeEducation: collegeEducation.text,
    highSchoolEducation: highSchoolEducation.text,
    image: image
  );

    
    
}