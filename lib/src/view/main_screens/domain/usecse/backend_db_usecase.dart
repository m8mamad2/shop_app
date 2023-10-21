
import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:flutter/widgets.dart';
import 'package:project3/src/view/main_screens/domain/entities/backend_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/backend/backend_db_helper_repo_header.dart';


class BackendDBUseCase {
  final BackendDBHelperRepoHeader helperRepo;
  BackendDBUseCase(this.helperRepo);
  
  Future createUserPicture(BuildContext context,String imagePath)async => helperRepo.createUserPicture(context,imagePath);
  Future<Uint8List> getUserPicture()async =>  helperRepo.getUserPicture();

  Future updateUserInfoData(BuildContext context,String key,dynamic value)async =>  helperRepo.updateUserInfoData(context, key, value);
  // Future createUserInfoData(BuildContext context,BackendDBEntity data)async =>  helperRepo.createUserInfoData(context, data);
  Future<Map<String,dynamic>> getUserInfoData() async =>  helperRepo.getUserInfoData();

  Future<User?> curretnUer() async => await helperRepo.curretnUser();
}