import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/core/widget/dialogs.dart';
import 'package:project3/src/view/main_screens/domain/entities/backend_db_entity.dart';
import 'dart:typed_data';

import 'package:project3/src/view/main_screens/domain/repo/backend/backend_db_helper_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/repo/backend/backend_db_repo_header.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/backend_db_bloc/backend_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/screen/profile_screen.dart';
import 'package:project3/src/view/main_screens/presentation/screen/user_info_screen.dart';

import '../../../../authenticaton_screen/data/repo/auth_repo_body.dart';

class BackendDBHelperRepoBody implements BackendDBHelperRepoHeader{
  final BackendDBRepoHeader repo;
  BackendDBHelperRepoBody(this.repo);

  // @override
  // Future createUserInfoData(BuildContext context,BackendDBEntity data)async {
  //   return await repo.createUserInfoData(data)
  //       .then((value) async {
  //           bool isSuccess = value == 'OK' ? true : false;

  //           if(isSuccess){
  //             return await showDialog(
  //             context: context,
  //             builder: (context) => inUIDialogs(
  //               context, 
  //               'Success', 
  //               'Updating information was succfull',
  //               isSuccess,
  //               (){
  //                 context.navigationBack(context);
  //                 BlocProvider.of<BackendDbBloc>(context).add(InitialBackendDBEvent());
  //               }),);}

  //           else {
  //             return await showDialog(
  //               context: context,
  //               builder:(context) => inUIDialogs(
  //                 context, 
  //                 value,
  //                 'Updating information was not succfull', 
  //                 isSuccess,
  //                 ()=>context.navigationBack(context)));}
  //       }
  //     );
  // }

  @override
  Future updateUserInfoData(BuildContext context,String key, valye) async {
    return await repo.updateUserInfoData(key,valye)
        .then((value) async{
            bool isSuccess = value == 'OK' ? true : false;

            if(isSuccess ){
              return await showDialog(
                context: context,
                builder:(context) => inUIDialogs(
                  context, 
                  'Success',
                  'Updating information was succfull', 
                  isSuccess,
                  // () => context.navigatiomRemove(context, const UserInfoScreen(onPress: BottomNavigateWidget(selected: 4,)))
                  () {
                    context.navigationBack(context);
                    BlocProvider.of<BackendDbBloc>(context).add(InitialBackendDBEvent());
                  }
                  ));}

            else{ 
              return await showDialog(
                context: context,
                builder:(context) =>inUIDialogs(
                  context, 
                  value,
                  'Updating information was not succfull' ,
                  isSuccess,
                  ()=>context.navigationBack(context)));}

        }
      );
  }

  @override
  Future createUserPicture(BuildContext context,String imagePath) async {
    return await repo.createUserPicture(imagePath)
        .then((value)async{ 
            bool isSuccess = value == 'OK' ? true : false;
            
            if(isSuccess ){
              return await showDialog(
                context: context, 
                builder: (context) => inUIDialogs(
                  context, 
                  'Success',
                  'Updating Image was succfull', 
                  isSuccess, 
                  () {
                    context.navigationBack(context);
                    BlocProvider.of<BackendDbBloc>(context).add(InitialBackendDBEvent());
                  }),);}
              
            else {
              return await showDialog(
                context: context, 
                builder:(context) =>inUIDialogs(
                  context, 
                  value,
                  'Updating Image was not succfull', 
                  isSuccess, 
                  ()=>context.navigationBack(context)));}
        }
      );
  }
  
  @override
  Future<Map<String, dynamic>> getUserInfoData() async => await repo.getUserInfoData().then((value) {print(value);return value;}).catchError((err)=>print('in user info get$err'));

  @override
  Future<Uint8List> getUserPicture() async => await repo.getUserPicture().then((value) {print('Curretn User Success');return value;}).catchError((e)=> print('in get user pic $e'));

  @override
  Future<User?> curretnUser() async => await repo.currentUser().then((value) {print(value);return value;}).catchError((e)=>print('in curretn User helper Backend $e'));

  
}
