// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/core/common/global_state/model/model.dart';
import 'package:project3/src/view/authenticaton_screen/data/repo/auth_repo_body.dart';
import 'package:project3/src/view/main_screens/data/data_source/remote/backend_initial.dart';
import 'package:project3/src/view/main_screens/data/repo/backend/backend_db_repo_body.dart';

import '../bloc/global_bloc.dart';

class GlobalRepo{
  BuildContext context;
  GlobalRepo({required this.context});
  
  AuthRepoBody authRepo = AuthRepoBody();
  Storage storage = Storage(BackendInitial.instance.client);
  Databases databases = Databases(BackendInitial.instance.client);
  Account account = Account(BackendInitial.instance.client);



  Future<void> save()async{
    BackendDBRepoBody backendRepo = BackendDBRepoBody(authRepo, storage, databases, account);
    Map userInfo = await backendRepo.getUserInfoData();

    bool? isLoggin = await authRepo.isUserLoggedIn();
    Uint8List? image = await backendRepo.getUserPicture();
    String? name = userInfo['name'];

    GlobalModel model = GlobalModel(isLoggin: isLoggin,image: image,name: name);

    context.read<GlobalBloc>().add(SaveDataGlobalEvent(model: model));  
  
  }

  Future<void> delete()async{
    GlobalModel model = GlobalModel(image: null,isLoggin: null,name: null);
    context.read<GlobalBloc>().add(SaveDataGlobalEvent(model: model));
  }

  Future<void> saveForSignup()async{
    GlobalModel model = GlobalModel(isLoggin: true,image: null,name: null);
    context.read<GlobalBloc>().add(SaveDataGlobalEvent(model: model));
  }


}