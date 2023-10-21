import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:project3/src/view/main_screens/data/model/chat_mdoel.dart';
import 'package:project3/src/view/main_screens/domain/usecse/chat_usecase.dart';

import '../../../domain/entities/chat_entity.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatUseCase useCase;
  ChatBloc(this.useCase) : super(InitialChatState()) {
    on<InitialChatEvent>((event, emit) async {

      emit(LoadingChatState());

      List<ChatEntity> messages = useCase.getBox();
      
      try{

        if(event is InitialSocketChatEvent)await useCase.initiSocket();
        if(event is AddToboxChatEvenet)await useCase.addToBox(event.entity);
        if(event is ClearBoxChatEnvet)await useCase.clearBox();

        emit(SuccessChatState(
          messages: messages
        ));
      }

      catch(e){emit(FailChatState(e.toString()));}
      
    });
  }
}
