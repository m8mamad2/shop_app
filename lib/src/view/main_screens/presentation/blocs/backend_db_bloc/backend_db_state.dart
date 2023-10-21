part of 'backend_db_bloc.dart';

@immutable
abstract class BackendDbState {}

class InitialBackendDBState extends BackendDbState {}

class LoadingBackendDBState extends BackendDbState {}

class SuccessBackendDBState extends BackendDbState {
  final Map<String,dynamic> userInfoData ;
  final Uint8List? image;
  final User? currentUser;
  // final bool isLoading;
  SuccessBackendDBState({required this.userInfoData,required this.image,required this.currentUser});
}

class FailBackendDBState extends BackendDbState {
  final String? error;
  FailBackendDBState(this.error);
}
