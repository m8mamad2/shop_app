
import 'package:flutter/material.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/dialogs.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/repo/contact_db_repo_header.dart';
import 'package:project3/src/view/main_screens/domain/repo/contacts_db_helper_repo_header.dart';
import 'package:project3/src/view/main_screens/presentation/screen/contact/contacts_screen.dart';

class ContactsDBHelperRepoBody extends ContactsDBHelperRepoHeader{

  ContactDBRepoHeader repo;
  ContactsDBHelperRepoBody(this.repo);

  @override
  Future createBoxHelper(BuildContext context,ContactDBEntity data) async {
    return await repo.createBox(data)
      .then((value)async {
        bool isSuccess = value == 'OK' ? true : false;

        if(isSuccess){return await showDialog(context: context, 
          builder: (context)=> inUIDialogs(context,'Success','Adding user was successful',isSuccess,()=>context.navigatiomRemove(context, const ContactsScreen())));}
          
        else {return await showDialog(context: context, 
          builder: (context)=> inUIDialogs(context,'Fail','Adding user was not successful',isSuccess,()=>context.navigatiomRemove(context,const ContactsScreen())));}
      });
  }

  

  @override
  Future updateBoxHelper(BuildContext context,String key,ContactDBEntity value) async {
    return await repo.updateBox(key, value)
    .then((value) async {
        bool isSuccess = value == 'OK' ? true : false;
        if(isSuccess){return await showDialog(context: context, 
          builder: (context)=> inUIDialogs(context,'Success','Updating user was successful',isSuccess,()=>context.navigatiomRemove(context,const ContactsScreen())));}
          
        else {return await showDialog(context: context, 
          builder: (context)=> inUIDialogs(context,'Success','Updation user was not successful',isSuccess,()=>context.navigationBack(context)));;}
      });
  }

  @override
  Future deleteFromBoxHelper(int index,BuildContext context) async => await repo.deleteFromBox(index).then((value) => context.navigatiomRemove(context, const ContactsScreen()));

  @override
  Future<List<ContactDBEntity>> getBoxHelper() async => await repo.getBox();
}