import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';

abstract class ContactDBRepoHeader{
  Future<String> createBox(ContactDBEntity data);
  Future<String> updateBox(String key,ContactDBEntity value);
  Future<void> deleteFromBox(int index);
  Future<List<ContactDBEntity>> getBox();
}