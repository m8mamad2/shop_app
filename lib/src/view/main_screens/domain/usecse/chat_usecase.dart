
import 'package:project3/src/view/main_screens/domain/entities/chat_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/chat_repo_header.dart';

import '../../data/model/chat_mdoel.dart';

class ChatUseCase{
  ChatRepoHeader chatRepo;
  ChatUseCase(this.chatRepo);

  Future<void> addToBox(ChatEntity entity) async => await chatRepo.addToBox(entity);
  Future<void> clearBox() async => await chatRepo.clearBox();
  Future<void> deleteFromBox(int id) async => await chatRepo.deleteFromBox(id);
  List<ChatEntity> getBox() => chatRepo.getBox();
  Future<void> initiSocket() async => await chatRepo.initSocketIO();

}