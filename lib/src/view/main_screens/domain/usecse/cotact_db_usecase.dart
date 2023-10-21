import 'package:flutter/material.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/contacts_db_helper_repo_header.dart';

class ContactDBUsecase{
  final ContactsDBHelperRepoHeader repo;
  ContactDBUsecase(this.repo);


  Future addToBox(BuildContext context ,ContactDBEntity data) async => await repo.createBoxHelper(context,data);
  Future deleteFromBox(int index,BuildContext context) async => await repo.deleteFromBoxHelper(index,context) ;
  Future updateBox(BuildContext context ,String key,dynamic value) async => await repo.updateBoxHelper(context,key, value) ;
  Future<List<ContactDBEntity>> getFromBox() async => await repo.getBoxHelper();
}
