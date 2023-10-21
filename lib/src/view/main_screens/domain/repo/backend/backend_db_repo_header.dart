import 'dart:typed_data';
import 'package:appwrite/models.dart';

abstract class BackendDBRepoHeader{
  Future<String> createUserPicture(String imagePath);
  Future<Uint8List> getUserPicture();
  
  Future<String> updateUserInfoData(String key,dynamic value);
  // Future<String> createUserInfoData(BackendDBEntity data);
  Future<Map<String,dynamic>> getUserInfoData();

  Future<User?> currentUser();
}