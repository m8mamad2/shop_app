import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project3/src/view/main_screens/domain/entities/chat_entity.dart';

part 'chat_mdoel.g.dart';

@HiveType(typeId: 5)
class ChatModel extends ChatEntity{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? messgae;

  @HiveField(2)
  final String? from;

  @HiveField(3)
  final String? to;

  @HiveField(4)
  final String? time;

  ChatModel(
    this.id,
    this.messgae,
    this.from,
    this.to,
    this.time,
  ):super(
    id: id,
    from: from,
    message: messgae,
    time: time,
    to: to
  );

  factory ChatModel.fromEntity(ChatEntity entity)=> ChatModel(
    entity.id!, 
    entity.message, 
    entity.from, 
    entity.to, 
    entity.time,);


  Map<String,dynamic> toJson()=>{
    'id':id,
    'ChatModel':messgae,
    'from':from,
    'to':to,
    'time':time
  };



}