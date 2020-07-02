import 'package:eaw/api_model/GoogleProvider.dart';
class GoogleRepo{
  GoogleProvider googleProvider = GoogleProvider();
  Future signInGoogle()=> googleProvider.handleSignIn();
  Future signOutGoogle()=> googleProvider.handleSignOut();
  Future checkLogin()=> googleProvider.checkLogin();
}