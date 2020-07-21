import 'package:connectivity/connectivity.dart';
import 'package:eaw/pages/NoInternetPage.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FirstTimePage extends StatefulWidget {
  final BuildContext context;
  FirstTimePage(this.context);
  @override
  _FirstTimePageState createState() => _FirstTimePageState();
}

class _FirstTimePageState extends State<FirstTimePage> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // Notification while the app is open
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
  }

  _FirstTimePageState() {
    checkNetWork();
  }
  checkFirstTime() async {
    await common
        .firstTimeBuild()
        .then((value) => WidgetsBinding.instance.addPostFrameCallback((_) {
              if (value) {
                common.getNavigator(context, Pages.getLoadingToHomePage, null);
              } else {
                common.getNavigator(context, Pages.getLoginPage, null);
              }
            }));
  }

  checkNetWork() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NoInternetPage(
                  context: context,
                  pages: Pages.getFirstTimePage,
                )),
      );
    } else {
      await checkFirstTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue[900],
        child: Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 50.0,
          ),
        ));
  }
}
