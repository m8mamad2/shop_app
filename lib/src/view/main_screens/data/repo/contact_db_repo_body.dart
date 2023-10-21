
import 'package:flutter/material.dart';
import 'package:project3/src/view/main_screens/data/data_source/local/init_hive_db.dart';
import 'package:project3/src/view/main_screens/data/model/local/contact_db_model.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/contact_db_repo_header.dart';
import 'package:uuid/uuid.dart';

class ContactDBRepoBody extends ContactDBRepoHeader{

  @override
  Future<String> createBox(ContactDBEntity entity) async {
    final data = ConcatsDBModel.fromEntity(entity);
    data.id = const Uuid().v1().toString();

    return await boxList[2].put(data.id,data)
      .then((value) => 'OK')
      .catchError((e)=>e.toString());
    }

  @override
  Future<void> deleteFromBox(int index)async => await boxList[2].deleteAt(index).then((value) => print('success Delete')).catchError((e)=>print(e.toString()));


  @override
  Future<List<ContactDBEntity>> getBox()async => boxList[2].values.toList() as List<ContactDBEntity>;

  @override
  Future<String> updateBox(String key,ContactDBEntity value)async {
    final data = ConcatsDBModel.fromEntity(value);
    return await boxList[2].put(key, data).then((value) => 'OK').catchError((e)=> e.toString());}
} 