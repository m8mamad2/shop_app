
import 'package:project3/src/view/main_screens/domain/entities/chat_entity.dart';

import '../../data/model/chat_mdoel.dart';

abstract class ChatRepoHeader{
  Future<void> addToBox(ChatEntity entity);
  List<ChatEntity> getBox();
  Future<void> clearBox();
  Future<void> deleteFromBox(int id);
  Future initSocketIO();
}