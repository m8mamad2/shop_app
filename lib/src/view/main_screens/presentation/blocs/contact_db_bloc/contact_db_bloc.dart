// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/usecse/cotact_db_usecase.dart';

part 'contact_db_event.dart';
part 'contact_db_state.dart';

class ContactDbBloc extends Bloc<ContactDbEvent, ContactDbState> {
  ContactDBUsecase usecase;
  ContactDbBloc(this.usecase) : super(InitialContactDBState()) {
    on<InitialContactDBEvent>((event, emit) async{

      emit(LoadingContactDBState());

      List<ContactDBEntity> data = await usecase.getFromBox();

      try{
        
        if(event is AddToCotactsBoxEvent){
          await usecase.addToBox(event.context,event.data);
          emit(SuccessContactDBState(data: data));
          }

        if(event is DeleteFromCotactsBoxEvent){
          await usecase.deleteFromBox(event.index,event.context);
          emit(SuccessContactDBState(data: data));
          }

        if(event is UpdateCotactsBoxEvent){
          await usecase.updateBox(event.context,event.key, event.value);
          emit(SuccessContactDBState(data: data));
          }

        emit(SuccessContactDBState(data: data));
      }
      
      catch(e){emit(FailContactDBState(e.toString()));}
      
      
    });
  }
}
