
// ignore_for_file: avoid_print

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:project3/src/view/main_screens/data/data_source/remote/backend_initial.dart';
import 'package:project3/src/view/authenticaton_screen/domain/repo/auth_repo_head.dart';

import '../../../../core/common/constans/texts.dart';
import '../../../main_screens/data/model/backend_db_model.dart';

class AuthRepoBody extends AuthRepoHead {
  AppwriteException exception = AppwriteException();
  final Account account = Account(BackendInitial.instance.client);
  final Databases databases = Databases(BackendInitial.instance.client);

  @override
  Future<String> signUp(String email, String password) async {

    try{
     final res= await account.create(userId: ID.unique(), email: email, password: password)
          .then((value) async => account.createEmailPasswordSession(email: email, password: password));

    final curretnUser = await account.get();
    await databases.createDocument(
        databaseId: kBackendDatabaseId, 
        collectionId: kBackendCollectionId, 
        documentId: curretnUser.$id, 
        permissions: [Permission.write(Role.user(curretnUser.$id))],
        data: BackendDBModel.forSignUp(curretnUser.$id));
    
      print(res.$id);
      return 'OK';
    }
    on AppwriteException catch(e){print('=====> sign up${e.message}');return e.message!;}
    catch(e){print('=====> sign up$e');return  e.toString();}
    
  }

  @override
  Future<String> logIn(String email, String password) async {
    try{
      await account.createEmailPasswordSession(email: email, password: password);
      return  'OK';
    }
    on AppwriteException catch(e){print(e);return e.message!;}
    catch(e){print(e);return e.toString();}
    
  }

  @override
  Future<String> logOut() async {
    final user = await account.get();
    print('---------> $user');

    try{
      await account.deleteSession(sessionId:'current');
      return  'OK';
    }
    on AppwriteException catch (e){ print(e); return e.message??'Error Appwrite';}
    catch(e){ print(e); return e.toString();}

  }

  @override
  Future<String> curretnUser() async {

    try{
      User user =await account.get();
      return user.$id;
    }
    on AppwriteException catch (e){
      print(e);
      return '';
    }
    catch(e){
      print(e);
      return '';
    }
    
  }

  @override
  Future<bool> isUserLoggedIn() async {
    bool isUserLogged = false;

    try{
      String user = await curretnUser();
      if(user.isNotEmpty && user != '')return isUserLogged = true;

    } on AppwriteException catch(e0){
      print(e0.message);
      return isUserLogged = false;
      }

    catch(e){print(e);return isUserLogged = false;}

    return isUserLogged;
  }
}

