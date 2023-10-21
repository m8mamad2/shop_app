
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../model/model.dart';

part 'global_event.dart';

class GlobalBloc extends HydratedBloc<GlobalBLocEvent, GlobalModel> {
  GlobalBloc() : super(GlobalModel()) {
    on<SaveDataGlobalEvent>((event, emit) => emit(event.model!) );
  }
  
  @override
  GlobalModel fromJson(Map<String, dynamic> json) {
    return json['data'] as GlobalModel;
  }
  
  @override
  Map<String, dynamic> toJson(GlobalModel state) => {'data' : state};
  
}
