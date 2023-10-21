
// ignore_for_file: invalid_return_type_for_catch_error, avoid_print
import 'dart:async';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:project3/src/core/common/constans/texts.dart';
import 'package:project3/src/view/authenticaton_screen/domain/repo/auth_repo_head.dart';
import 'package:project3/src/view/main_screens/domain/repo/backend/backend_db_repo_header.dart';

class BackendDBRepoBody implements BackendDBRepoHeader{
  final AuthRepoHead repo;
  final Storage storage ;
  final Databases databases;  
  final Account account;
  BackendDBRepoBody(this.repo,this.storage,this.databases,this.account);

  
  //* picture
  @override
  Future<String> createUserPicture(String imagePath) async {

    try{
      String curretnUser  = await repo.curretnUser();

      await storage.createFile(
        bucketId: kBackendBucketId, 
        fileId: curretnUser, 
        file: InputFile.fromPath(path: imagePath));
      print('success');
      return 'OK';
    }
    on AppwriteException catch(e){print(e); return  e.message ?? 'on Create User Picture';}
    catch(e){print(e); return e.toString();}

  }
  
  @override
  Future<Uint8List> getUserPicture() async  {
    final Uint8List errorRes= Uint8List(0);
    try{
      String curretnUser  = await repo.curretnUser();
      Uint8List res = await storage.getFileView(
          bucketId: kBackendBucketId, 
          fileId: curretnUser);
      return res;

    }
    on AppwriteException catch(e){print(e);return errorRes;}
    catch(e){print(e); return errorRes;}

  }

  @override
  Future<User?> currentUser() async {
    try{
      return await account.get();
    }
    on AppwriteException catch(e){print(e);return null;}
    catch(e){print(e.toString());return null;}
  }

  // * info
  
  @override
  Future<Map<String,dynamic>> getUserInfoData()async {
    try{
      String curretnUser = await repo.curretnUser();
      Document doc = await databases.getDocument(
        databaseId: kBackendDatabaseId, 
        collectionId: kBackendCollectionId, 
        documentId: curretnUser);
      return doc.data;
    }

    on AppwriteException catch(e){print('-------. in GET info$e'); return {'':e.message};}

    catch(e){print(' in Get INFO$e'); return {'':e.toString()};}
    
  }
  
  @override
  Future<String> updateUserInfoData(String key,dynamic value)async {

    try{
      String curretnUser = await repo.curretnUser();
      await databases.updateDocument(
        databaseId: kBackendDatabaseId, 
        collectionId: kBackendCollectionId, 
        documentId: curretnUser,
        permissions: [Permission.write(Role.user(curretnUser))],
        data: {key:value});
      print('update Success');
      return 'OK';
    }
    on AppwriteException catch(e){ print(e); return e.message?? 'on update user info';}
    catch(e){ print(e); return  e.toString();}
    
  }
  
}
