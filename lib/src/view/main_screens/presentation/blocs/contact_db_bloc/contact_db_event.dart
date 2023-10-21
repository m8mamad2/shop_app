part of 'contact_db_bloc.dart';

@immutable
abstract class ContactDbEvent {}

class InitialContactDBEvent extends ContactDbEvent{}

class AddToCotactsBoxEvent extends InitialContactDBEvent{
  final BuildContext context;
  final ContactDBEntity data;
  AddToCotactsBoxEvent(this.data,this.context);
}

class DeleteFromCotactsBoxEvent extends InitialContactDBEvent{
  final int index;
  final BuildContext context;
  DeleteFromCotactsBoxEvent(this.index,this.context);
}

class UpdateCotactsBoxEvent extends InitialContactDBEvent{
  final BuildContext context;
  final String key;
  final ContactDBEntity value;
  UpdateCotactsBoxEvent(this.key,this.value,this.context);
}

