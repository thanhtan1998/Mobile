import 'package:eaw/dto/LoginRequest.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/SharedPreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  LoginRequest loginRequest = LoginRequest();
  GoogleProvider() {
    firebaseMessaging.getToken().then((value) => loginRequest.fcmToken = value);
  }
  Future<LoginRequest> handleSignIn() async {
    handleSignOut();
    try {
      final GoogleSignInAccount googleUser =
          await _googleSignIn.signIn().catchError((onError) {
        print("Error $onError");
      });
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final firebaseUser = await (await _auth.signInWithCredential(credential))
          .user
          .getIdToken();
      loginRequest.firebaseToken = firebaseUser.token;
    } catch (exception) {
      print(exception.toString());
    }
    return loginRequest;
  }

  Future handleSignOut() async {
    common.currentIndex = 0;
    await _auth.signOut();
    await _googleSignIn.signOut();
    sharedRef.removeAllObject();
  }
}
