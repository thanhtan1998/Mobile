import 'package:eaw/resource/CommonComponent.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingToHomePage extends StatefulWidget {
  BuildContext context;
  LoadingToHomePage(this.context);
  @override
  _LoadingPageState createState() => _LoadingPageState(context);
}

class _LoadingPageState extends State<LoadingToHomePage> {
  @override
  void initState() {
    super.initState();
  }

  void getFireBaseUser() async {
    changePage(common.firebaseUser != null);
  }

  void changePage(bool isLogin) async {
    if (isLogin)
      common.getNavigator(context, Pages.getHomePage, null);
    else
      common.getNavigator(context, Pages.getLoginPage, null);
  }

  BuildContext context;
  _LoadingPageState(this.context);
  @override
  Widget build(BuildContext context) {
    getFireBaseUser();
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
