part of 'global_bloc.dart';

@immutable
abstract class GlobalBLocEvent {}

class SaveDataGlobalEvent extends GlobalBLocEvent{
  final GlobalModel? model;
  SaveDataGlobalEvent({required this.model});
}