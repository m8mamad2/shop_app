// // ignore_for_file: use_build_context_synchronously

// import 'dart:typed_data';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/widgets.dart';
// import 'package:meta/meta.dart';
// import 'package:project3/src/view/main_screens/domain/entities/backend_db_entity.dart';
// import 'package:project3/src/view/main_screens/domain/repo/backend/backend_db_helper_repo_header.dart';
// import 'package:project3/src/view/main_screens/domain/usecse/backend_db_usecase.dart';

// part 'backend_db_event.dart';
// part 'backend_db_state.dart';

// class BackendDbBloc extends Bloc<BackendDbEvent, BackendDbState> {
//   final BackendDBUseCase useCase;
  
  
//   BackendDbBloc(this.useCase) : super(InitialBackendDBState()) {
//     on<InitialBackendDBEvent>((event, emit) async{
//       emit(LoadingBackendDBState());

//       Future<Map<String,dynamic>> userInfoData = useCase.getUserInfoData();
//       Future<Uint8List> userPicture = useCase.getUserPicture();

//       try{
//         if(event is CreateUserInfoDataBackendDBEvent)return await useCase.createUserInfoData(event.context, event.data);
        
//         if(event is CreateUserPictureBackendDBEvent){
//           emit(LoadingBackendDBState());
//           print('eeeeeeeeeeeeeeeeeeeeee');
//           await useCase.createUserPicture(event.context, event.imagePath)
//             .then((value) => print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'));
//           emit(SuccessBackendDBState(userInfoData: userInfoData, image: userPicture));
//           print('oooooooooooooooooooooooooooooooooooo');
//           }
          
//         if(event is UpdateUserInfoDataBackendDBEvent)return await useCase.updateUserInfoData(event.context, event.key, event.value);

//         emit (SuccessBackendDBState(
//           userInfoData: userInfoData,
//           image: userPicture
//         ));

//       }
//       catch(error){emit(FailBackendDBState(error.toString()));}
      
      
//     });
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:project3/src/view/main_screens/domain/entities/backend_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/backend/backend_db_helper_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/usecse/backend_db_usecase.dart';

part 'backend_db_event.dart';
part 'backend_db_state.dart';

class BackendDbBloc extends Bloc<BackendDbEvent, BackendDbState> {
  final BackendDBUseCase useCase;
  
  
  BackendDbBloc(this.useCase) : super(InitialBackendDBState()) {

    
    on<InitialBackendDBEvent>((event, emit) async{

      emit(LoadingBackendDBState());

      Map<String,dynamic> userInfoData =await useCase.getUserInfoData();
      Uint8List? userPicture =await useCase.getUserPicture();
      User? curretnUser = await useCase.curretnUer();

      try{

        // if(event is CreateUserInfoDataBackendDBEvent){
        //   await useCase.createUserInfoData(event.context, event.data);
        //   emit(SuccessBackendDBState(userInfoData: userInfoData, image: userPicture,currentUser: curretnUser));}
        
        if(event is CreateUserPictureBackendDBEvent){
          await useCase.createUserPicture(event.context, event.imagePath);
          emit(SuccessBackendDBState(userInfoData: userInfoData, image: userPicture,currentUser: curretnUser));}
          
        if(event is UpdateUserInfoDataBackendDBEvent){
          await useCase.updateUserInfoData(event.context, event.key, event.value);
          emit(SuccessBackendDBState(userInfoData: userInfoData, image: userPicture,currentUser: curretnUser));}

        emit (SuccessBackendDBState(
          userInfoData: userInfoData,
          image: userPicture,
          currentUser: curretnUser,
        ));

      }
      catch(error){emit(FailBackendDBState(error.toString()));}
      
      
    });
  }
}

