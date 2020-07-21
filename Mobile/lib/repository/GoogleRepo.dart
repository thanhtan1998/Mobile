import 'package:eaw/api_model/GoogleProvider.dart';

class GoogleRepo {
  GoogleProvider googleProvider = GoogleProvider();
  Future signInGoogle() async => googleProvider.handleSignIn();
  Future signOutGoogle() async => googleProvider.handleSignOut();
}
