part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class InitialChatState extends ChatState {}

class LoadingChatState extends ChatState {}
class SuccessChatState extends ChatState {
  final List<ChatEntity> messages;
  SuccessChatState({required this.messages});
}
class FailChatState extends ChatState {
  final String error;
  FailChatState(this.error);
}
