import 'package:flutter/cupertino.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';

abstract class ContactsDBHelperRepoHeader {

  Future<dynamic> createBoxHelper(BuildContext context,ContactDBEntity data);
  Future deleteFromBoxHelper(int index,BuildContext context);
  Future updateBoxHelper(BuildContext context,String key,ContactDBEntity value);
  Future<List<ContactDBEntity>> getBoxHelper();
}