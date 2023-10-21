part of 'backend_db_bloc.dart';

@immutable
abstract class BackendDbEvent {}

class InitialBackendDBEvent extends BackendDbEvent{}

class CreateUserPictureBackendDBEvent extends InitialBackendDBEvent{
  final BuildContext context;
  final String imagePath;
  CreateUserPictureBackendDBEvent(this.context,this.imagePath);
}

// class CreateUserInfoDataBackendDBEvent extends InitialBackendDBEvent{
//   final BuildContext context;
//   final BackendDBEntity data;
//   CreateUserInfoDataBackendDBEvent(this.context,this.data);
// }

class UpdateUserInfoDataBackendDBEvent extends InitialBackendDBEvent{
  final BuildContext context;
  final String key;
  final dynamic value;
  UpdateUserInfoDataBackendDBEvent(this.context,this.key,this.value);
}