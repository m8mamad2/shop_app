import 'dart:typed_data';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/view/main_screens/domain/entities/backend_db_entity.dart';

abstract class BackendDBHelperRepoHeader{
  Future createUserPicture(BuildContext context,String imagePath);
  Future<Uint8List> getUserPicture();

  Future updateUserInfoData(BuildContext context,String key,dynamic value);
  // Future createUserInfoData(BuildContext context,BackendDBEntity data);
  Future<Map<String,dynamic>> getUserInfoData();

  Future<User?> curretnUser();
}