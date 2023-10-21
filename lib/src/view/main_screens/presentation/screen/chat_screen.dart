import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project3/src/view/main_screens/domain/entities/chat_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

import '../../data/data_source/local/init_hive_db.dart';


class ChatScreen extends StatefulWidget {
  final String name;
  const ChatScreen({required this.name});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {  
  final TextEditingController _messageController = TextEditingController();

  Box<ChatEntity> box = boxList[4] as Box<ChatEntity>;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(InitialChatEvent());
    BlocProvider.of<ChatBloc>(context).add(InitialSocketChatEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Chat App'),
        leading: IconButton(onPressed: ()async => context.read<ChatBloc>().add(ClearBoxChatEnvet()),icon:const Icon(Icons.delete)),
      ),
      body: BlocBuilder<ChatBloc,ChatState>(
        builder:(context, state) =>  Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<Box<ChatEntity>>(
                valueListenable: box.listenable(),
                builder:(context, box, child) => ListView.builder(
                shrinkWrap: true,
                padding:const EdgeInsets.only(top: 10,bottom: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: box.length,
                itemBuilder: (context, index) {
                    
                    final messages = box.values.toList()..sort((a, b) => a.time!.compareTo(b.time!),);
      
      
                    return Container(
                      padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                      child: Align(
                        alignment: (messages[index].to == "back"?Alignment.topRight:Alignment.topLeft),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].to  == "back"?Colors.blue:Colors.grey.shade200),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(messages[index].message!, style: const TextStyle(fontSize: 15),),
                        ),
                      ),
                    );
                  }
                ),
              )
            ),
            Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width:MediaQuery.of(context).size.width - 60,
                          height: MediaQuery.of(context).size.height * 0.095,
                          child: Card(
                            elevation: 9,
                            margin: const EdgeInsets.only(left: 2, right: 2, bottom: 15),
                            color: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _messageController,
                              textAlignVertical:TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "type something",
                                suffixIcon: InkWell(
                                  onTap: ()async{
                                    DateTime date = DateTime.now();
      
                                    ChatEntity data = ChatEntity(
                                        id: const Uuid().v4(),
                                        message: _messageController.text, 
                                        from: 'me', 
                                        to: 'back', 
                                        time: '${date.toLocal().hour}:${date.toLocal().minute},${date.millisecondsSinceEpoch}');
                                      
                                    context.read<ChatBloc>().add(AddToboxChatEvenet(data));
      
                                    _messageController.clear();
                                  },
                                  child: Container(
                                    margin:const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                                    width: MediaQuery.of(context).size.width * 0.15,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child:  Icon(Icons.send,color: Colors.black,size: 25,),
                                  ),
                                ),
                                contentPadding:const EdgeInsets.symmetric(horizontal: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          )
            
         
          ],
        ),
      ),  
    );
  }
}


