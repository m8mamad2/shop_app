
// ignore_for_file: avoid_print

import 'package:project3/src/view/main_screens/data/data_source/local/init_hive_db.dart';
import 'package:project3/src/view/main_screens/data/data_source/remote/chat_initial.dart';
import 'package:project3/src/view/main_screens/data/model/chat_mdoel.dart';
import 'package:project3/src/view/main_screens/domain/entities/chat_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/chat_repo_header.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatRepoBody extends ChatRepoHeader{

  Socket socket = ChatInitial.socket;

  @override
  Future initSocketIO()async{
    socket.connect();
    socket.on('message', (data) => print('Message: $data'));
  }




  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> addToBox(ChatEntity entity)async {
    ChatModel model = ChatModel.fromEntity(entity);

    socket.emit('message',model.toJson());

    await boxList[4].put(model.id, model)
      .then((value) => print('Success'))
      .catchError((e)=>print('Error _______ $e'));
  }

  @override
  Future<void> clearBox() async => await boxList[4].clear();

  @override
  Future<void> deleteFromBox(int id) async => await boxList[4].deleteAt(id);

  @override
  List<ChatEntity> getBox() => boxList[4].values.toList() as List<ChatEntity>;
  
}