import 'package:appwrite/models.dart';

abstract class AuthRepoHead {
  Future<String> logIn(String email, String password);
  Future<String> logOut();
  Future<String> signUp(String email, String password);
  Future<bool> isUserLoggedIn();
  Future<String> curretnUser();
}
