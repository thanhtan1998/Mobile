import 'package:eaw/resource/CommonComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class GoogleProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String idToken, accessToken;

  Future handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    idToken = googleAuth.idToken;
    accessToken = googleAuth.accessToken;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: accessToken,
      idToken: idToken,
    );
    common.firebaseUser = (await _auth.signInWithCredential(credential)).user;
    final idtoken =await common.firebaseUser.getIdToken();
    final token = idtoken.token;
    print("common: ${token}   @------------------------");
  }

  Future handleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future checkLogin() async {
    final FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      return common.firebaseUser;
    }
    return null;
  }
}
