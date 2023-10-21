part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class InitialChatEvent extends ChatEvent{}

class InitialSocketChatEvent extends InitialChatEvent{}

class AddToboxChatEvenet extends InitialChatEvent{
  final ChatEntity entity;
  AddToboxChatEvenet(this.entity);
}

class ClearBoxChatEnvet extends InitialChatEvent{}

