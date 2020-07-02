import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FcmHandler extends StatefulWidget {
  @override
  _FcmHandlerState createState() => _FcmHandlerState();
}

class _FcmHandlerState extends State<FcmHandler> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // Notification while the app is open
        print('áaaaaaa');
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        // Clicked on notification

        print('onlaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        // App running in background

        print('onResume: $message');
      },
    );
    firebaseMessaging.getToken().then((token){
      print('FCM Token: $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
